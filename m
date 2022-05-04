Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5A519C68
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbiEDJ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiEDJ6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:58:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB2286D9;
        Wed,  4 May 2022 02:54:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i19so1821916eja.11;
        Wed, 04 May 2022 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TfvVKp6AkwRbq+jAIJDqhghg2eRcDHqJH8bycnO2Thw=;
        b=E3z2I+NBUfSCR21hiF9iDq2sioocRjLNwF/AYut+EAiw2Uz3Eg/qJ2RXi3+zNvCVNk
         zN15rrYpafWNEreJqLDP+t3ib9jSgfC8hfSEHnPQ6RORNw2C9K+NCZ/uaqQHQQT9dgGj
         pE7JoOZ/R8bDrhWMjf4mD8fY5+PZEpO5jLFT6cmk0FFaPmKApHp22I9Xk7o1WVI0Nufq
         X0qdnGy5cK5mYtvcZT1n6J/8AUf+ShN7ZugPn86cj4rN6SqbXImI5G/z0rrTXYcMsj75
         aFOIwQZPMBDKxxnxdzs3i0oWdpZh7QH7K6zqJLIx+EKax7sRHXJFq1A6Kg/uAmv0FbA5
         3nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TfvVKp6AkwRbq+jAIJDqhghg2eRcDHqJH8bycnO2Thw=;
        b=U0GignBkfl7O3d2KShkYbAnpTSfP5rcTUwLJW9XXj1yl8p+tA6wkzlUqFaWNoKMTrl
         FXr3puiRTybHlTgkV3RZKGhrGndlyc1pOemWtWIFjvKmGWFiFkJjNGxPkeZPt0KEKYUp
         8LenPU1oBYX2917SCudN1Pu8GXKouGhLBsw0aEiVrLyZXu2u0wwNz13AvQOjBldVz6Yy
         pVxdS+YZoruCKkY5BlF81wsPFABe0+3lOzj50Gcg8w9+YVTSq98Ak8AmbqX/Xb3ACzRx
         rx0GKDp/ZeFYgBU/5YEiZShq/S6IUo+wQYMZgHjDGq8fIgUJN2vNTPaO9cxq7UXdyHRJ
         n6+Q==
X-Gm-Message-State: AOAM531G1MSXyio0HCdwEJcSv3s86rROtmqjdzEtXr945QBIGBMvPrE8
        mY8qmVpmMfDhdbMX7F/Tw1iGVVsu8g==
X-Google-Smtp-Source: ABdhPJybCpwemBTPeZ+m5IJa9Wf7RRx3orImU2O0p/+HkMyXtiKmUBYFgeM+t8J3ZuJ1ySLxsD3EXg==
X-Received: by 2002:a17:907:6d07:b0:6f3:d077:813a with SMTP id sa7-20020a1709076d0700b006f3d077813amr19942702ejc.138.1651658063146;
        Wed, 04 May 2022 02:54:23 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.36])
        by smtp.gmail.com with ESMTPSA id d12-20020a50fb0c000000b0042617ba6399sm8913640edq.35.2022.05.04.02.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 02:54:22 -0700 (PDT)
Date:   Wed, 4 May 2022 12:54:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2] module: fix [e_shstrndx].sh_size=0 OOB access
Message-ID: <YnJNTIJeB2NHK9Jh@localhost.localdomain>
References: <YnFC93NVRqOterbV@localhost.localdomain>
 <YnGNSNcUbkwLNWNd@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnGNSNcUbkwLNWNd@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is trivial to craft a module to trigger OOB access in this line:

	if (info->secstrings[strhdr->sh_size - 1] != '\0') {

BUG: unable to handle page fault for address: ffffc90000aa0fff
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 100000067 P4D 100000067 PUD 100066067 PMD 10436f067 PTE 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 7 PID: 1215 Comm: insmod Not tainted 5.18.0-rc5-00007-g9bf578647087-dirty #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
RIP: 0010:load_module+0x19b/0x2391

Fixes: ec2a29593c83 ("module: harden ELF info handling")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/module.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3033,6 +3033,10 @@ static int elf_validity_check(struct load_info *info)
 	 * strings in the section safe.
 	 */
 	info->secstrings = (void *)info->hdr + strhdr->sh_offset;
+	if (strhdr->sh_size == 0) {
+		pr_err("empty section name table\n");
+		goto no_exec;
+	}
 	if (info->secstrings[strhdr->sh_size - 1] != '\0') {
 		pr_err("ELF Spec violation: section name table isn't null terminated\n");
 		goto no_exec;


Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/module.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3033,6 +3033,10 @@ static int elf_validity_check(struct load_info *info)
 	 * strings in the section safe.
 	 */
 	info->secstrings = (void *)info->hdr + strhdr->sh_offset;
+	if (strhdr->sh_size == 0) {
+		pr_err("empty section name table\n");
+		goto no_exec;
+	}
 	if (info->secstrings[strhdr->sh_size - 1] != '\0') {
 		pr_err("ELF Spec violation: section name table isn't null terminated\n");
 		goto no_exec;
