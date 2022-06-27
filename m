Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119D555C9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiF0JMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiF0JMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:12:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021D2667
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:12:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 504171FAD6;
        Mon, 27 Jun 2022 09:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656321162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hWcCqwO3BTodK8igIZw+OA8TsjbOJ7vRUphPsAiYNv4=;
        b=eeRgR8VepGtYhh2IgHJ7MPaSon2kC3s6egMSpO80f5L/5WThzmff4qewigVLB+qJH0ZuiK
        RyXfaMTuLi70NRl7KBO4wEm55ZMvF83BXRZEuXzpVxAhe0PnOFIqR7mmiQ3HTy9ZSkMKeW
        aOIpRpowQ0O+6qqnHcE0FY9rx7XZIUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656321162;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hWcCqwO3BTodK8igIZw+OA8TsjbOJ7vRUphPsAiYNv4=;
        b=3gYlwMlEoElkfTm6cd/wO/q3VHQTTqvtC51R3D2kE8IUa5YnQaypTGqU4CXX87A8rJEBdX
        PseDLBPqHiUkCrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 362C113456;
        Mon, 27 Jun 2022 09:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qcRbDIp0uWKHIgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 27 Jun 2022 09:12:42 +0000
Message-ID: <f69f7f28-cf24-ebca-41f2-f6cf76435839@suse.de>
Date:   Mon, 27 Jun 2022 11:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Matthew Wilcox <matthew@wil.cx>, Mel Gorman <mgorman@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
From:   Hannes Reinecke <hare@suse.de>
Subject: Oddities in do_read_cache_page()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Matt,

I've stumbled across this code in do_read_cache_page():

         struct folio *folio;

         folio = do_read_cache_folio(mapping, index, filler, file, gfp);
         if (IS_ERR(folio))
                 return &folio->page;
         return folio_file_page(folio, index);

Following 'do_read_cache_folio()' I see that it does things like

                 folio = filemap_alloc_folio(gfp, 0);
                 if (!folio)
                         return ERR_PTR(-ENOMEM);

Now I freely admit that my knowledge of folios is hazy at best, but 
dereferencing an error pointer is something I would seriously frown upon 
  if I were to review the code.
Care to explain?
Or is it, indeed, simply a bug?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
