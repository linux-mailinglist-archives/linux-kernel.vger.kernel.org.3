Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5084D0502
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244399AbiCGRME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243195AbiCGRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:12:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EA585660
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:11:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C4A21F37C;
        Mon,  7 Mar 2022 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646673061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEjkUspmy19fLDLs9qhqoOiHf6dLn/m7lz0Ro537UFY=;
        b=SGQpSG6FzpDZMOPddCVGoePKHtyUeF4pRtnjW4Oh4VDNuZSzlgf5I3UY6tuuGuBn8b14R8
        /REcmMJJ9r+1Qmmlnk9AbjlblcEVLiVG+QqpgdN7f4BVFdGiXUY8UvMvWA9k5IjPBonybH
        n5ArVPoS/A8igJOW8H+T3xcOomnT230=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646673061;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEjkUspmy19fLDLs9qhqoOiHf6dLn/m7lz0Ro537UFY=;
        b=W0GN8J/6A7tq1LavfKCI1Z9CvtFTxKS/4KtjUz7Bi5H+PbAQdTNCsHmzasuclFRzHXPVkp
        Sdr2oehH9pfteQBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 434B513BA5;
        Mon,  7 Mar 2022 17:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tNY4D6U8JmJUWgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Mar 2022 17:11:01 +0000
Message-ID: <5192817a-ed77-50c9-7bca-86d85b4b91dd@suse.cz>
Date:   Mon, 7 Mar 2022 18:11:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm/slub: helper macro __ATTR_XX to make code more clear
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>,
        Lianjie Zhang <zhanglianjie@uniontech.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220306073818.15089-1-zhanglianjie@uniontech.com>
 <88c427-faec-ba5f-4ed4-bc2dd0873ec0@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <88c427-faec-ba5f-4ed4-bc2dd0873ec0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/22 23:11, David Rientjes wrote:
> On Sun, 6 Mar 2022, Lianjie Zhang wrote:
> 
>> Signed-off-by: Lianjie Zhang <zhanglianjie@uniontech.com>
> 
> And VERIFY_OCTAL_PERMISSIONS() can help validate any future change.
> 
> Acked-by: David Rientjes <rientjes@google.com>

Ok, adding with adjusted subject and non-empty message:

    mm/slub: use helper macro __ATTR_XX_MODE for SLAB_ATTR(_RO)
    
    This allows more concise code, and VERIFY_OCTAL_PERMISSIONS() can help
    validate any future change.

