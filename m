Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96C5A2207
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbiHZHdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245399AbiHZHcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:32:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C46D3E42;
        Fri, 26 Aug 2022 00:32:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88C7C1F899;
        Fri, 26 Aug 2022 07:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661499148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igO3aCWiZrDo7asASAY8M5geW4VNm9Nc1tyv8UuQpic=;
        b=taAY9QM63kehnSiVeCYN/v9DRn77iJtD08OJWeHCYB7jNBb+WiISAdAyP0jxwk8V/wYnND
        XqxpnMjkByoDhbJlm7316KuhDu9gEXTE9G9epAedhxCa+LDWTCq9qLvt0kl/nRTKZRBBww
        lHzKdMIIRFc6avhan3AnvfwPa2f1KqQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68A9C13421;
        Fri, 26 Aug 2022 07:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U/jxFgx3CGNfDwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 26 Aug 2022 07:32:28 +0000
Date:   Fri, 26 Aug 2022 09:32:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <Ywh3C4dKB9B93jIy@dhcp22.suse.cz>
References: <20220826171020.5772e600@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826171020.5772e600@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-08-22 17:10:20, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> arch/powerpc/xmon/xmon.c: In function 'cmds':
> arch/powerpc/xmon/xmon.c:1089:33: error: too few arguments to function 'show_mem'
>  1089 |                                 show_mem(0, NULL);
>       |                                 ^~~~~~~~
> In file included from arch/powerpc/xmon/xmon.c:14:
> include/linux/mm.h:2585:13: note: declared here
>  2585 | extern void show_mem(unsigned int flags, nodemask_t *nodemask, gfp_t gfp_mask);
>       |             ^~~~~~~~
> 
> Caused by commit
> 
>   9ea9abc5cd7e ("mm: reduce noise in show_mem for lowmem allocations")
> 
> I have reverted that commit for today (and the following fix).

This should fix it. Andrew, could you fold it into the patch please?
git grep doesn't suggest more instances AFAICS
--- 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 3d9782ea3fa7..19b1a94b0c00 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1086,7 +1086,7 @@ cmds(struct pt_regs *excp)
 				memzcan();
 				break;
 			case 'i':
-				show_mem(0, NULL);
+				show_mem(0, NULL, GFP_HIGHUSER_MOVABLE);
 				break;
 			default:
 				termch = cmd;


-- 
Michal Hocko
SUSE Labs
