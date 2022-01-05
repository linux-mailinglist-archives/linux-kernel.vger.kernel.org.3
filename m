Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7649484FF2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiAEJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiAEJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:22:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0EC061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 01:22:32 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s15so1513276plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 01:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4xfp6CvEJH53YpVF7NoIR4W7WJmaRDYx9TOiF5fZvk=;
        b=pzntNYzQoq7fieH9S6EzCJAKxBPFIgpNJ6vOhcmRgOw6o54+5T8cCDHf0wP+fDKizr
         CuQnfY+er2z+Ta6vGVeRhQhQeSVQdjNQKFeGsxg/yAH+mowM0mUvmZ/5BZFGL2QqkM2u
         g0fLSQaqsn1Tly4S0rBbcIL4Nyk3Hw4iNEM1Drst3NMIcLwUvnVsYUhqm9GBhkLYzCO/
         A5CQUEQ7sh5jm5Pp/+MdUXdm9lM0XVdjzDfpvU4D3gI8Tgky4FI2YUgyTarElH39q5mN
         vOKaCUq5PyOVQqUvF8S9hsj7M4GoATJW4yZx/yBdvZYBZ29kVt+w4iTwxTsfnCoq0jHF
         3ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4xfp6CvEJH53YpVF7NoIR4W7WJmaRDYx9TOiF5fZvk=;
        b=KbtlaGnDpNyp77lmc0vr2IzOolbRH5Y5BTSZWw5sozaUEVMac4LFF4bqwgajaVsCMC
         EBjgF/0As9YJCr8kDkUCkd/uhs6yz7i/1fJm2njgNr8yYkXpltiC/IkZtqDSjgZWmmdZ
         oIi6056Nmo+3xwM25FWw9HUb/bAOqneT0Jd2SGFA/Ip/mWfjxyVrngcwNDyYiScKx+Kc
         tN0PdgKB02QDRMJnTRV9z1nH3joX+ueRYx6m+8mvvtYFWtNwre7VM5XJRqo0NfqRp6QK
         aN1bPQtEwCX6PPWO0MVfDZCzpwGY8B63jqiZaoqB8QiRUMrOi1lTcQvUDEFKW6LnAPlR
         NnCA==
X-Gm-Message-State: AOAM531pvasT2KqZIyuhcBVJgNaj+7IctQDoA3CbvrS3VhJ5CSNj1Z+Z
        7OZe5eL3dYYK+A8qpi9ZOqQ=
X-Google-Smtp-Source: ABdhPJyZu377ZIk3x3tbCz5avW/A16Fs8irkz0vIcQcbm3TLVlFE5VsqWxhTKnK7vuB311NTd2LYGA==
X-Received: by 2002:a17:903:22ca:b0:149:b1e2:a8ca with SMTP id y10-20020a17090322ca00b00149b1e2a8camr18896555plg.46.1641374552415;
        Wed, 05 Jan 2022 01:22:32 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a3sm46936261pfv.47.2022.01.05.01.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 01:22:32 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, cgel.zte@gmail.com, chi.minghao@zte.com.cn,
        fkassabri@habana.ai, linux-kernel@vger.kernel.org,
        obitton@habana.ai, ogabbay@kernel.org, osharabi@habana.ai,
        ynudelman@habana.ai, zealci@zte.com.cn
Subject: Re: [PATCH misc-next] drivers/misc: remove redundant rc variable
Date:   Wed,  5 Jan 2022 09:22:29 +0000
Message-Id: <20220105092229.617027-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YdQzUPW5FI0yIi0P@kroah.com>
References: <YdQzUPW5FI0yIi0P@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that there are indeed some optimizations
after removing the redundancy.

For example:

int foo(int a, int b)
{
        int ret;
        ret = a>b ? a: b;
        return ret;
}
int main()
{
        int val;
        val = foo(7,2);
        return 0;
}

and

int foo(int a, int b)
{
        return a>b ? a: b;
}
int main()
{
        int val;
        val = foo(7,2);
        return 0;
}

The corresponding disassembly code is as follows：

    1129:       f3 0f 1e fa             endbr64 
    112d:       55                      push   %rbp
    112e:       48 89 e5                mov    %rsp,%rbp
    1131:       89 7d fc                mov    %edi,-0x4(%rbp)
    1134:       89 75 f8                mov    %esi,-0x8(%rbp)
    1137:       8b 45 fc                mov    -0x4(%rbp),%eax
    113a:       39 45 f8                cmp    %eax,-0x8(%rbp)
    113d:       0f 4d 45 f8             cmovge -0x8(%rbp),%eax
    1141:       5d                      pop    %rbp
    1142:       c3                      retq

and

    1129:       f3 0f 1e fa             endbr64 
    112d:       55                      push   %rbp
    112e:       48 89 e5                mov    %rsp,%rbp
    1131:       89 7d ec                mov    %edi,-0x14(%rbp)
    1134:       89 75 e8                mov    %esi,-0x18(%rbp)
    1137:       8b 45 ec                mov    -0x14(%rbp),%eax
    113a:       39 45 e8                cmp    %eax,-0x18(%rbp)
    113d:       0f 4d 45 e8             cmovge -0x18(%rbp),%eax
    1141:       89 45 fc                mov    %eax,-0x4(%rbp)
    1144:       8b 45 fc                mov    -0x4(%rbp),%eax
    1147:       5d                      pop    %rbp
    1148:       c3                      retq

After removing the redundancy, the compiler does
have some optimizations

