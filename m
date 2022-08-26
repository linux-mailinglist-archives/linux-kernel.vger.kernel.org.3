Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCD15A2619
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbiHZKtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiHZKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:49:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016349C518;
        Fri, 26 Aug 2022 03:49:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A934E1FD70;
        Fri, 26 Aug 2022 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661510966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGXZZ/m7SoogwzlUL+uXlfvJVcmYUkZYvpET1c52fwk=;
        b=dwm/N0A79JigO03wc29QRnnKo/WSIUXnaFMh6W8OD0ASGhDUPMeoZm0sIQadsjrGn3oWej
        uLTlUgzhboyA04fizKUvw8nlWqy3s+5GGpUt91emgsuaijIPTULCxxPCt+dveAH3IhxW/e
        nOgcIsBd7tMg4ADA3T+ry1w2Vfv4tiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661510966;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGXZZ/m7SoogwzlUL+uXlfvJVcmYUkZYvpET1c52fwk=;
        b=rXAPNaQ6Yv6S62E1pJTbEPNgFg2K/pvVmit+ULFartQQMhb/dIC9+yCYQn3iGRjqf+V3Pn
        OsdTzXoZFi/YsCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 744BC13A7E;
        Fri, 26 Aug 2022 10:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IFJ0GzalCGP9ZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Aug 2022 10:49:26 +0000
Message-ID: <68133fc4-7034-c07b-f14b-5b4e73e04d2c@suse.cz>
Date:   Fri, 26 Aug 2022 12:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4] page_ext: introduce boot parameter 'early_page_ext'
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, lizhe.67@bytedance.com
Cc:     mhocko@suse.com, mhiramat@kernel.org, keescook@chromium.org,
        Jason@zx2c4.com, mark-pk.tsai@mediatek.com, rostedt@goodmis.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com
References: <20220825102714.669-1-lizhe.67@bytedance.com>
 <20220825212338.e541d29ca3c4d602221f4925@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220825212338.e541d29ca3c4d602221f4925@linux-foundation.org>
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


On 8/26/22 06:23, Andrew Morton wrote:
> On Thu, 25 Aug 2022 18:27:14 +0800 lizhe.67@bytedance.com wrote:
> 
>> From: Li Zhe <lizhe.67@bytedance.com>
>> 
>> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
>> we call page_ext_init() after page_alloc_init_late() to avoid some panic
>> problem. It seems that we cannot track early page allocations in current
>> kernel even if page structure has been initialized early.
>> 
>> This patch introduce a new boot parameter 'early_page_ext' to resolve this
>> problem. If we pass it to kernel, function page_ext_init() will be moved
>> up and feature 'deferred initialization of struct pages' will be disabled
>> to initialize the page allocator early and prevent from the panic problem
>> above. It can help us to catch early page allocations. This is useful
>> especially when we find that the free memory value is not the same right
>> after different kernel booting.
>> 
> 
> WARNING: modpost: vmlinux.o: section mismatch in reference: early_page_ext_enabled (section: .text.unlikely) -> early_page_ext (section: .meminit.data)
> WARNING: modpost: vmlinux.o: section mismatch in reference: early_page_ext_enabled (section: .text.unlikely) -> early_page_ext (section: .meminit.data)

Hm it's a very small static inline, shouldn't exist separately anywhere.
Maybe it's due to that new debug info level thing?

Would this work instead?

----8<----
diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 884282a7f03a..4bf4e58cf2d4 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -40,7 +40,7 @@ extern bool early_page_ext;
 extern unsigned long page_ext_size;
 extern void pgdat_page_ext_init(struct pglist_data *pgdat);
 
-static inline bool early_page_ext_enabled(void)
+static inline bool __meminit early_page_ext_enabled(void)
 {
 	return early_page_ext;
 }

