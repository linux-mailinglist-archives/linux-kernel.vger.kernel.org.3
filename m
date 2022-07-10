Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94F56CFDE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGJPyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:54:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A7A65AA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:54:41 -0700 (PDT)
Received: from mail-yb1-f169.google.com ([209.85.219.169]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MA7Su-1oGabF3iIs-00BbnQ for <linux-kernel@vger.kernel.org>; Sun, 10 Jul
 2022 17:54:40 +0200
Received: by mail-yb1-f169.google.com with SMTP id 6so5224474ybc.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 08:54:39 -0700 (PDT)
X-Gm-Message-State: AJIora9igV0xbQ58CKmB/EBYNd09816B+r7UHAoN0svnCo3eNmJms8KH
        kcJ0hDWq8Dsvv15N4b1qElgUCb0u3aL5KwhzQUI=
X-Google-Smtp-Source: AGRyM1v76RqBo2D7VhFl4oAJQaPAg7TpvkmoPNin90N0WFoFrvnqtRzOLmYN6ml20bwZUgBEMBYB8fqRnilO9oXeKmI=
X-Received: by 2002:a25:7c41:0:b0:66d:766a:4815 with SMTP id
 x62-20020a257c41000000b0066d766a4815mr13465980ybc.480.1657468478668; Sun, 10
 Jul 2022 08:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220709211549.1163327-1-shorne@gmail.com> <20220709211549.1163327-2-shorne@gmail.com>
In-Reply-To: <20220709211549.1163327-2-shorne@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 10 Jul 2022 17:54:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Mw0Q9_W+xawMe=7UfiQiJT98wybygqg8E8gEuurZCuw@mail.gmail.com>
Message-ID: <CAK8P3a0Mw0Q9_W+xawMe=7UfiQiJT98wybygqg8E8gEuurZCuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] openrisc: Add pci bus support
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nREpe+ULXivFkdtmgefleSYSRPsULSNop+g8fdehJ1HTjFir4iy
 Xrw8QmmXZuER+40jEqFRGe3FzcE7qolNTPRgr3QeTrMh2cdDJaCT6Z7aORfLm17DH1TMUOJ
 KGVqCqqMMFPNThCv81dYVshTrjQNOHYb3mKf4tsvbki5ELymQETg2mSVUQNCUJpwjgySW/t
 +ffrKi/uw2bEarfFeVlMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:40gBQ9MyTeM=:opLzRjLZPL7E+SLY43nOR8
 ds4jy6cs0q8HUG0cKnEKkXsRwZLyaorPqx5c23ySekGJT+ps461+oOokgw3Fl93mZjAhjPsZR
 YOz5FILR6OmJpF5oQ00xDyMEG21kctAsLRy+U96+jON63jnGvyMviCHPJ7DEwSKG5b+avdHqx
 aIdetyUQI1A2ACaCg5WWA13+DeBDlPQnxv2aJqpq897AuVVHMbxkfCKIAelkHm8/EWLqNp9TW
 0VTbqJ816A++cXY1IASDAykMk5rtg3q9HQT7ceEJjbFrBTfANRyckqXVVYbreqW9/poejyLaT
 E5JLvBDsJhtsKd6k4OvU9lOgwv150uRvcejvD5Npk68+KDs16IpDJxmyJsjgIWy85G/hdTOcG
 BNVUuW+8exvrZ0OQ3mMW/srsqs9bF8VHnK+nqN4TQ1BepU5I9bREQ72jpzDLj+AchpnJRFmV+
 AeK/AvxDmUXeGlsAmlCMnDjEYxJ1MhmsHuE1U63Pt1RUm1EEEdfjElfsrV4CukfP0scaG/ERX
 GE/xdyP+TA3qt2oPSNmGh3Ju8/ZASHmnAYNAOcQ9nXhdCMbjOwrsM9jzMc6wapbgjdSkZpLXV
 NG3M1sCMOP7Msxpze1euS5JQ5dJkf9IBu/n9TKtUMlj+kz+VCF4u8nF1ZxItGwtD6gByXELUM
 Z3lAMN33bIDwYQxFCKUMND26taeMnbFKT8yJm1q7yyA/yU+QovtvjhFtf5xncbaYzy0b0FTRn
 nGmcQCvUYKeb4A68jLDAJXdD01S9ebk8+b2/Ew==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 9, 2022 at 11:15 PM Stafford Horne <shorne@gmail.com> wrote:
>
> This patch adds required definitions to allow for PCI buses on OpenRISC.
> This is being in the QEMU virt platform.
>
> OpenRISC does not have IO ports so this defines PCI IO to be allowed in
> any range.  Keeping PIO_RESERVED defined as 0 allows OpenRISC to use
> MMIO for all IO.

>
>  /*
> - * PCI: can we really do 0 here if we have no port IO?
> + * PCI: All address space can be used for IO
>   */
> -#define IO_SPACE_LIMIT         0
> +#define IO_SPACE_LIMIT ~(0UL)

I think '0' is the correct limit here if you don't support PCI controllers
that can map their I/O ports into MMIO space. If you don't define
PCI_IOBASE to a meaningful value and set IO_SPACE_LIMIT as you
do here, every virtual address is treated as an I/O port, so accessing
a low port through /dev/ioport or a PCI driver results in an access to
a NULL pointer, which is either a userspace address or low kernel
memory, both of which are bad.

Most PCI controller are however able to map I/O ports into the
physical address space of the CPU, and in that case you can just
define an otherwise unused address as PCI_IOBASE and map the
ports there from the PCI host bridge driver.

       Arnd
