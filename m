Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55214CC083
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiCCPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiCCPAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:00:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA36B12B75E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 06:59:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m6so8261117wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNxMNrhC8hxbhlWJ6ODupu1+HNUrX3voNWdFu6lxXOA=;
        b=oVMw6jWiyYVEcfm/nYooZXG16phKkvUAL/Z5ODqDvwEfWHb2lbKABvUR5k+81VEkIe
         LMOwSPD+nxj0ZBLjeVgKdH+XzT/OC8Gbsqkn4k5ofDgqy2qca3HSQMkGy+9tweukADAn
         AFQrv9t/zslVKWirf5B5f2esn0L8MfMzLFGUjoe2AZpiVYTsibSx+IBcgbMcAyiSCq2I
         ELP3WCpTjEuhHXiTr9SM3KAQDhQrGalpAkhJ6v1ZmNTFFVqYv00QJSR7rWoZm4xmxiLd
         uZIO1MYIlGjdDnK+bqHC+SKu+7m4ZyvTJBPpAI056iPZA/XSf6Pvsqq9RCHue9QPLI01
         vfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bNxMNrhC8hxbhlWJ6ODupu1+HNUrX3voNWdFu6lxXOA=;
        b=qhBCgOppRb3qzfTLqhm5jeV6IoK65WiDC4MXIsTpYCGxp3DpMjloLOUyr6lxPxw9gO
         hVNvgD7PKzrF3xCWoplrt3Nelr1o9uQjDjMJ4MyI1YiHI5kesgj4Zsq5qK2OZCXSBUAL
         JT1KnKJ1ZIbN0v+8viLtfqBkUrsTP27URYlqOEE+LgDoa95EscvPYlwGm1Xgd/nlKEd+
         XBbjznkpbdc8XFBC7giUJgbQ+P9T1EGl8r6MzPO9NtjgDDVhlxuGcUxSWAXYhcK8TrzB
         sMqEmZaxbRGS/+37wdtSQl4zOleORHvFoJ7bQE/ACOvjnK6mF7I6NxhZIgaZAs19ul/9
         QriA==
X-Gm-Message-State: AOAM530vTd9aLvKjf+FE4SngYHDGjIV93Gor40FmVrNOLv29XlV+llsD
        OJPgNVa7ccv75OPIoB1ztHP13g==
X-Google-Smtp-Source: ABdhPJx05mYM4sjB0FOVEW1Pa7DDwK8ny1KwoP/DgYLnmhoVXk7sB2d/Ouenui3Gq8IoOMULZvVUHQ==
X-Received: by 2002:adf:d1c9:0:b0:1ea:830d:f1b0 with SMTP id b9-20020adfd1c9000000b001ea830df1b0mr27232134wrd.522.1646319592535;
        Thu, 03 Mar 2022 06:59:52 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b00380ee4a78fdsm3100578wmq.4.2022.03.03.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 06:59:51 -0800 (PST)
Date:   Thu, 3 Mar 2022 14:59:49 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220303145949.inaz2tecmfuek2hf@maple.lan>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <YiDEmRf3X0fxSayK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiDEmRf3X0fxSayK@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 05:37:29AM -0800, Christoph Hellwig wrote:
> On Wed, Mar 02, 2022 at 08:56:23PM +0000, Christophe Leroy wrote:
> > Do we really want to hide the 'struct list_head modules' from external 
> > world ?
> > 
> > Otherwise we could declare it in include/linux/module.h ?
> 
> I'd just move the trivial code that uses it from kernel/kdb/ to
> kernel/module/ as it is tied to module internals and just uses the
> KDB interfaces exposed to other parts of the kernel.

One of the best ways that we can common up code might be to dust
off some code I wrote a while back to display seq_files from
kdb.

The basic idea worked well enough but it often needs special
start/stop operatings to ensure the start meeds kdb's rather
odd locking restrictions. If there is a willingness for
something like the below to be included in the module code then we
could replace kdb_lsmod() with something that reused the code to
 format /proc/modules.


Daniel.


diff --git a/kernel/module.c b/kernel/module.c
index 84a9141a5e159..ab43ee23cdba0 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4664,7 +4664,33 @@ static int __init proc_modules_init(void)
        return 0;
 }
 module_init(proc_modules_init);
-#endif
+
+#ifdef CONFIG_KGDB_KDB
+static void *kdb_m_start(struct seq_file *m, loff_t *pos)
+{
+       static LIST_HEAD(empty);
+       struct list_head *modlist = &modules;
+
+       if (mutex_is_locked(&module_mutex)) {
+               pr_info("Cannot display module list because it is
locked\n");
+               modlist = empty;
+       }
+
+       return seq_list_start(modlist, *pos);
+}
+
+const struct seq_operations kdb_modules_seqops = {
+       .start  = kdb_m_start,
+       .next   = m_next,
+       .show   = m_show
+};
+#endif /* CONFIG_KGDB_KDB */
+
+/*
+ * TODO: Need to decide if it OK to disable kdb lsmod if
+ * !CONFIG_PROC_FS... but it probably is!
+ */
+#endif /* CONFIG_PROC_FS */
 
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned
long addr)
