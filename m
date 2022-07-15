Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752185758A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiGOAaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiGOAaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:30:13 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CDA67CB6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:30:11 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bb16so4340988oib.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2y/bRWdrE6PknWUfOr49D67DacrQqJC2LFsgWNk0Y08=;
        b=bVvFSjYP1AC38tnyGp0DkBPhExptuvki0alnKs1ljCDwyAF6r8UywkndRWlo7r59+A
         qL/1Na4Rg95/gvkG51UfSyYcXEm3XlMeQ3xJYETlQ+LCkORddgYXdtALN8U7+VkvAzcB
         +pcApIohOVp60Y0UdzBsxxTiW0eHZGeXAY6VlaGGRBdD4UPwx/1uXq8lcLRPyMT7GcH+
         p1t3NgnRW3yJCVuFON61NE637EqeJCil6tbYznSCNvYj5fZkRBz0VukVNqxfnuGik59x
         oCwslppN3iTbO+yMIaKOxrP3Rg+AScPnJrOu5/woBDcsvZAF1nAQowOT5XdAq7zzJ/WU
         X/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2y/bRWdrE6PknWUfOr49D67DacrQqJC2LFsgWNk0Y08=;
        b=hggipKjrbwiP3ea9GM2ZB/BHMu3B1e+uBY0CQ2Kb1Qd80FAKYTLXZXezn3x+OOBCQH
         nD3HkPCqonTi9Z692kY17SQEVcLxJdi8oXJ3tpZ2PCrrqFSNxYTo6n2IMCIflqaQeoTG
         J9PD7JDs/yvpH0Fenh8jYCWwp61/faeSHZUIT7uSNV0QYBDe1s9eq9JRMfwzV51wyGIz
         Voc6Zl/6QkYZsuByq96EOxAHTnxWiNOJqk0XBzVsDFw+0vSyOfWmSqAZxDaeq3g+165S
         RKhHkyl9loT9DeCxvm5NN1Cy9fLix1/PC4ezs7WJPte//g53o75Etf1ciZlsrOkTd1lX
         llqw==
X-Gm-Message-State: AJIora/93IQYOv40Fgnr1k2YVfutaANnn/540L9CVRYUU2UCBxgysHUR
        BzgTRfaZk87ZdEBXmtRX7rTAHEoNvWACk0NzadP9inJ+W761Gg==
X-Google-Smtp-Source: AGRyM1soLUMwcjsE6jDXApdSR+KjB9+WB2b9q4a0+HiGObdb9awXlav0hJ3WR1H9Nz2/NIj/jqunBi+nect7Hn1BMRQ=
X-Received: by 2002:a05:6808:2124:b0:335:7483:f62d with SMTP id
 r36-20020a056808212400b003357483f62dmr8905045oiw.112.1657845009367; Thu, 14
 Jul 2022 17:30:09 -0700 (PDT)
MIME-Version: 1.0
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 14 Jul 2022 17:29:58 -0700
Message-ID: <CALMp9eS5pBrKWe=LbWXON6bhTdhbX9rB2aF+c-h_a0=SXfyj7A@mail.gmail.com>
Subject: Retbleed (RSBA vs BTC)
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What is the value in conflating the Intel and AMD findings under the
same moniker (arch/x86/kernel/cpu/common.c)? The vulnerabilities seem
quite different to me.

The Intel CPUs tagged with RETBLEED should already report RSBA. The
paper just highlights this previously disclosed vulnerability. Or are
there Intel CPUs subject to Retbleed that don't report RSBA, and I'm
just confused?

On the AMD side, however, Branch Type Confusion is a much bigger deal.
All instructions are subject to steering by BTI, not just returns with
an empty RSB.

Don't these two vulnerabilities deserve separate names (and don't we
already have a name for the first one)?

Tangentially, I believe that the following line is wrong:
VULNBL_INTEL_STEPPINGS(SKYLAKE_X, X86_STEPPING_ANY, MMIO | RETBLEED),

Steppings 5, 6, and 7 are "Cascade Lake," with eIBRS, and I don't
think Cascade Lake suffers from RSBA.
