Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA44691CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhLFIzP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Dec 2021 03:55:15 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60991 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbhLFIzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:55:13 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MNKuI-1nERUL1rAY-00OlZA; Mon, 06 Dec 2021 09:51:43 +0100
Received: by mail-wr1-f49.google.com with SMTP id v11so20791488wrw.10;
        Mon, 06 Dec 2021 00:51:43 -0800 (PST)
X-Gm-Message-State: AOAM5339y0pHeraHMXwt7i/T5+JgNxSU9exLI5HUSgKI0zzLYs7EVMlg
        FpizNg9yxXxvL25183GgZYD8D4VgBh4J6AHhoPM=
X-Google-Smtp-Source: ABdhPJzyalCAhEEEFCjxqmdft1YmW7S1cmbW+6xqxZ82QAJeL5WvlG6LnjE0IMFTe+6YI4aKV+WE7uH0MQlJtdL87s8=
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr42087288wri.137.1638780703113;
 Mon, 06 Dec 2021 00:51:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638275062.git.quic_saipraka@quicinc.com> <d578f7a68d6f9c250e5305e677c1b732c94f7ec6.1638275062.git.quic_saipraka@quicinc.com>
In-Reply-To: <d578f7a68d6f9c250e5305e677c1b732c94f7ec6.1638275062.git.quic_saipraka@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Dec 2021 09:51:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a05BPRhnKFO8_wTXfX6bbb2gV2xwjwgaYsDSNeQhHYCZw@mail.gmail.com>
Message-ID: <CAK8P3a05BPRhnKFO8_wTXfX6bbb2gV2xwjwgaYsDSNeQhHYCZw@mail.gmail.com>
Subject: Re: [PATCHv5 2/4] irqchip/tegra: Fix overflow implicit truncation warnings
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        quic_psodagud@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:yEqwBFW4eOMQF9x+kEzct8PISMOorGWfqoYQQttyZ+TTH7xg9xI
 KdmFkw/frHrx9Ui4jRmMIPOcSOF6iZ2jbjI9vcCQ6Avu5sITa00EDABbIPh8gmb3FhHshPK
 hfNokaDesZkqnG7weak2DXIeCsNQqm4Le920pr9WMTqrJerYIbvKGMGNTgR3T0HcfXl7Awy
 UdTZICjvW0gZ5JdGDuKzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:se6yjCSAFwo=:TgwPhBoK8clYU6HkE6Ns8y
 LTthzW/8sTOlvjP/F9956cEludycwJcP/1uBhyhGdV2MOzsz71RsbQa7g3VgmyfeQf2LNOfVs
 BGzA3rn5oKKPC36dhG3V+Sy+tlWWr4HgoeYU2VcgOtHNMKYM9N7MQZj2cxwH20XlG51IACZUF
 RYaM7Q1Dw0DpP/XoiQB7ArirEGyzVFsHRE8hFU25p9J9DlR+zeY/ArAnyPU/WM7EJUoXnZTvN
 pDaczF6CckcnTyRTx/BlwRs75opB59QFOviLCi4Cx7XbR4RjmcsCu5FhAo1fyDg2/GZO9PmCF
 Sx9a1KifmeBGx4HsiPPZHYGtkEhmxfeXVjxKd/bgidDspGLb9b7PuMpjM1nBLkCdacNiqH7Ql
 K1B7ZQI4kDara074Dm5XuSU3IitTj/3R2IEy2mGMUBB4UWePQptOFJgnGGsr4QLRtPT2WaNkR
 HVTfuMJza9uPvwS6s7pLHjyxmq0E1ogrPwjnpVWgoyApSbp3xyamYqoyYCGOLmr6kGS5rzo+U
 yU7i3mvRzNHX/Ef8YPi1ax9pIYTI/zMNH0T3qEtVzV8kOzAW6pOqvOR8ivdTrMJzbr+G+ZTrp
 h1uiA6ZjVxZnEHk8KixNnDnREEdxqpX1jYOCzhFQG2mo6OQc3lUk0OcPHZPxaR0C0HIDQQkPi
 2I3ElxpsyUCDg67f5zJj9rc0UnqT6imAia7tEwDtFDU4+Jfk87ZxQBENSuWrZ/0NixFEJQi6v
 iH3b6bjXlJhfBlSyVjWv3c+lSnsBwnFrMR4dF8lgC93XfBHLyk9yj142AIq5akZEsQOEGFmP2
 sFChm+7Kb8qAh3vGdfOt7QQp/PztG36eWzIrOiUt/icjTgzUsw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 9:28 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
>
> Fix -Woverflow warnings for tegra irqchip driver which is a result
> of moving arm64 custom MMIO accessor macros to asm-generic function
> implementations giving a bonus type-checking now and uncovering these
> overflow warnings.
>
> drivers/irqchip/irq-tegra.c: In function ‘tegra_ictlr_suspend’:
> drivers/irqchip/irq-tegra.c:151:18: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>    writel_relaxed(~0ul, ictlr + ICTLR_COP_IER_CLR);
>                   ^
>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
