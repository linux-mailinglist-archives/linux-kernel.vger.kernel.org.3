Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4FA4A6201
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiBARM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiBARMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:12:50 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABBDC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:12:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c2so13229808wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=y3cju/C1v6xq2FkyEnl4srGGHG1dkX4hOg+PsvipVd4=;
        b=mRt2ddyPFobYUwvKkvZTs3hAak6uUdJKuWwaHHauAUWmrxujcT6IgJ4939WIDrkUHo
         +2f5ig1PwQh/9WKblAklF/+yoUVZ7u2Zv/xf5YkybfTw1O1LQwz7PaQomLIB3pUUzo4C
         vORZji+u938740xD0SrB6DFqjLOLn+3B8LE90nkxcIIc5bFLfn//nGYYDieJfmCNNCLz
         f9YGC94PFKd5181uhuWjfycdfMcHDmLRwUTPqSnAAxFQsEgtr2z/6mliAJk9sntOru1V
         5M5jlEOpvUau4VI9r/CWcDet4M2ky7zkO4KBKf8ifI680LofLqu8ho2AzG761trFtrxz
         n6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=y3cju/C1v6xq2FkyEnl4srGGHG1dkX4hOg+PsvipVd4=;
        b=DgeXWCBbxbc8Wis0Rlkjdv3XmT2rd6WcVHBYTyV58FhHfFjplL6nstXL7Ca4RXP332
         sPGBDHLZ27xOgIdY/UC8tKUjz6Z6MEXsZcN9owBKC01SHFiKIfRrmjiKAuppq7Wdy5lm
         9q6B/nolE3mjm3fSuuJXdVVxaGZunk2HixmsGPXVE9LyK5wAuq5voIWi2G5CRgI63QzK
         oe8b5adjhI5q+Z2XSjzHOTdj5scE1oATmxMxfU4sYbVhw4fSja4ccsFQM7BpnJqwdkY4
         qcTTlZ0hD/s/Z8J+/mTEwwgFN54C+hsLarLJDibz29temoMnLlzafpFNXjLxm5iPVU0x
         kzSQ==
X-Gm-Message-State: AOAM531BQTlPiNpuJI4f1GJzm/vl7cnhuB2iuIouNgUV3r3c9U+2Hexq
        EjgnnJ5Y3WWldCe1B3CD+F/M49GOqb04z8QU
X-Google-Smtp-Source: ABdhPJyRBGFB6A+hjjogD4Uo+HkCIaf2yA2oCLnltnBuoMB5fOTL/uV+aBumW1uEE+qgikn60ng6qg==
X-Received: by 2002:a05:600c:1498:: with SMTP id c24mr2672717wmh.78.1643735568261;
        Tue, 01 Feb 2022 09:12:48 -0800 (PST)
Received: from ?IPV6:2a02:a310:8338:1200:67a8:b282:a39:10c4? ([2a02:a310:8338:1200:67a8:b282:a39:10c4])
        by smtp.gmail.com with ESMTPSA id o10sm17435082wri.19.2022.02.01.09.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:12:47 -0800 (PST)
Message-ID: <9b82908f-eed1-b6b7-62aa-ecbba7bf048b@gmail.com>
Date:   Tue, 1 Feb 2022 18:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
From:   =?UTF-8?Q?Borys_Pop=c5=82awski?= <poplawski.borys@gmail.com>
Subject: VDSO is randomized even when ASLR is disabled
To:     luto@kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I've stumbled upon an issue of VDSO address being randomized on x86_64 when ASLR is disabled. This happens only on systems with 5-level paging enabled. Details below.

Relevant code: "vdso_addr" in arch/x86/entry/vdso/vma.c
VDSO base address is picked at random starting from the stack bottom address so that it stays in the same PMD as the stack. This randomization is made regardless of PF_RANDOMIZE flag.
With ASLR off, stack is mapped at the highest possible address in 4-level paging, which is 0x7ffffffff000 - this leaves no space for VDSO after the stack, which effectively disables the above randomization. With 5-level paging the stack address stays the same, but "TASK_SIZE_MAX" is much greater, allowing for the above randomization.

This behavior is present in all versions (since VDSO was introduced on x64). I think the fix could be as simple as:

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 235a5794296a..0bc83e4ca512 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -326,7 +326,7 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
                end = TASK_SIZE_MAX;
        end -= len;
 
-       if (end > start) {
+       if (end > start && (current->flags & PF_RANDOMIZE)) {
                offset = get_random_int() % (((end - start) >> PAGE_SHIFT) + 1);
                addr = start + (offset << PAGE_SHIFT);
        } else {

but I've not tested it yet, figured I'll post here first.

Best regards,
Borys
