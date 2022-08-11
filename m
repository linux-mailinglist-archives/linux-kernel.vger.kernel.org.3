Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06358F646
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiHKDHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiHKDHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:07:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774EB7647C;
        Wed, 10 Aug 2022 20:07:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d20so15396138pfq.5;
        Wed, 10 Aug 2022 20:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=LmnOiDMX3xGrA/oiBCR1NQTWs1yu4LdDCazzpBCjFtQ=;
        b=H5cnkUVNltB7wWsF6EV6zhRHqMdbHRl1/9X0CDEmIn8sQxFUTqE3GaaBiao9RVv2Mz
         GWFL+fetVlJKW24AtbvGfvy+ha6lP+7aSEb6M/IgtNFMnQUj9oK6w8bnLM4z+77rsjHZ
         MRrtvBp8y8vyFudVo2+O9wjHDVEB9Sv3UpJbLXpDTfhjTxtHkflOHqPlh3slyuFq0hSO
         s+W6AVm5/scjepfNTCg7e+IerJuZBjTapd0T5672TOKc2FVLrnIC/0BPN0dWSX2qIGjC
         PpH1AyDTbPS0p3IdtusCKRavn/bxNhTlDX2GHN0uoXdU47oMbRAhkFK4Ue92EdUAtYRh
         N9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LmnOiDMX3xGrA/oiBCR1NQTWs1yu4LdDCazzpBCjFtQ=;
        b=6LdobB38vSgqgTxRKuRrXS5y1gu9QaZL4i7gw544AlDetR8/i2JCDiFHvzu1jQJzqI
         gSpkqBbX+ddULMGfYyB+50sjqq47BGGrVrjBapE8r4hN+WK0eHJdzcbhvv2gD4oTp1u3
         nv5wuFtefsa/TdNB9mtRbTLs6bi0ehU0RHFxEf9LQmwD61MKfdhM5Y8sLeviVlz7w7Sq
         FISpE/BUDGrMmznHa6//ALO9uqmOM6aNntY2FLeWoZAGaEG9gH2v8UK5wucGYXRSQh75
         2mZHtLpWXiQge/F4I0qdINYBGKjMQVxJfGxBKS/la0MvMb8YnHN8Rga9YflELYW87tXn
         Ha/w==
X-Gm-Message-State: ACgBeo3fZU5jxbP8GroBqXjl4vJ/1BpbtAW7+pjEp8cGYRBLDHghgO5P
        QYVjJpVH6Us5ouBTzE2oHg8=
X-Google-Smtp-Source: AA6agR5B0U4yEPzcfEMvg4EWSUMEiB5V88JgPoOag+aXjmtx75T7wOxR3QgN0r7Desc6C3h37KfZtA==
X-Received: by 2002:a63:4d0e:0:b0:412:1877:9820 with SMTP id a14-20020a634d0e000000b0041218779820mr25457368pgb.177.1660187220938;
        Wed, 10 Aug 2022 20:07:00 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id oj7-20020a17090b4d8700b001df264610c4sm10902763pjb.0.2022.08.10.20.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 20:07:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EB139103BCD; Thu, 11 Aug 2022 10:06:55 +0700 (WIB)
Date:   Thu, 11 Aug 2022 10:06:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V5 5/6] riscv: crash_core: Export kernel vm layout,
 phys_ram_base
Message-ID: <YvRyT5f5uH7LBs4H@debian.me>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 08:18:17PM +0800, Xianting Tian wrote:
> These infos are needed by the kdump crash tool. Since these values change
> from time to time, it is preferable to export them via vmcoreinfo than to
> change the crash's code frequently.
> 

I have to agree with Conor.Dooley, that this patch is misleading (I see
documentation instead of real export). So IMO, the patch subject should
be "Documentation: kdump: describe VMCOREINFO export for RISCV64".

For MODULES_VADDR and friends, the doc can be improved, like:

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 6b76284a503ca5..6694acc32c3588 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -615,14 +615,13 @@ phys_ram_base
 
 Indicates the start physical RAM address.
 
-MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
------------------------------------------------------------------------------
-KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
-----------------------------------------------------------------------
+MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END|KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
+----------------------------------------------------------------------------------------------------------------------------------------------------
 
 Used to get the correct ranges:
-	MODULES_VADDR ~ MODULES_END : Kernel module space.
-	VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
-	VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
-	KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
-	KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
+
+  * MODULES_VADDR ~ MODULES_END : Kernel module space.
+  * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
+  * VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
+  * KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
+  * KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
