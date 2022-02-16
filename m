Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8C4B8CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiBPPpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:45:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiBPPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:45:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1EC2A5989
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:45:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B2BF1F37D;
        Wed, 16 Feb 2022 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645026331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XvA8U4SyXCnsVseKo1yffsTrzZzqNOcqdAeYZByR8+I=;
        b=2Q53fou1I48/b1Noz3GJHj2JY6/nWjIJJ+yDMxryp4s/5pMmCaulIVGCad2VVPQx0If1LA
        foqCjjalX8Wp0ydrU0Iwo/4IXdFsACip3D2cCcNyZmm0OqKU8JKNSnFwG5FU3ZtwqqbmEb
        TCIy3qr/Q5KA3ozi4L7wN0O6px6ky44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645026331;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XvA8U4SyXCnsVseKo1yffsTrzZzqNOcqdAeYZByR8+I=;
        b=SAwW6Ub/Lwy40IYtgZGqLS7p8pjgIXHY5OVO945Ls+lkhtVrgLIZRqD6vw6s0fz5m+QyaJ
        L08F7rfWSp7Bi+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE23C13B15;
        Wed, 16 Feb 2022 15:45:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qUoSNxocDWJxOgAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 16 Feb 2022 15:45:30 +0000
Date:   Wed, 16 Feb 2022 16:45:29 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rafael Parra <rparrazo@redhat.com>
Subject: Re: [PATCH v2 2/2] drivers/base/memory: determine and store zone for
 single-zone memory blocks
Message-ID: <Yg0cGbrTA4bDEQHx@localhost.localdomain>
References: <20220210184359.235565-1-david@redhat.com>
 <20220210184359.235565-3-david@redhat.com>
 <YguFFRiNIktJhGnT@localhost.localdomain>
 <9738c049-a6a2-19f7-f9be-e7ae98c2c66b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9738c049-a6a2-19f7-f9be-e7ae98c2c66b@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 02:46:56PM +0100, David Hildenbrand wrote:
> And yes, add_memory_block() chould __init, that would also make it
> clearer out of which context init_memory_block() is called with
> MEM_ONLINE. I can send an addon patch for that!

Yeah, I think that would have helped me, and it definitely makes it more
clear, so go ahead ;-)


-- 
Oscar Salvador
SUSE Labs
