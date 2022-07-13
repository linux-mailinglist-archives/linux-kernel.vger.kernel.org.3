Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF960572BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiGMDTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiGMDTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:19:10 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C486B31C4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:19:09 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id o12so9113526pfp.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=R6xI0morLL57JUlbA0u3eGGm5aJePBaipJygvCaQ9U0=;
        b=2BzjTzbUXD1woQQGYOJ7CSmknNB/O8RnasV2LMyIW04QMAfAF3i6aldO/K/u/4ioDt
         hLdJe33qPcDPPAP8yb5qlaHVlsTECwjIMXNK1m+xG449/s/ilZ/hwVC3AhOIvUTW3Ovq
         jGoD17lRk59TH65lzQaqIe54ZEi5I/g+CdhXSWLyAe3gHxCkuqaIoWNY0/h4ssVfMMtQ
         1V3qugKEAA3RtRnAbsxiZ0FRcXvV+UEwDlXR5l/mJb4ewDjU7HubwrVCgH9uUirRx8v0
         orUlIU9mx3I99gNzrI+6a2YV62S95lfPCYg+8zpVDFDK02H6pdC9SzsA9REXUPw3dmq/
         fFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=R6xI0morLL57JUlbA0u3eGGm5aJePBaipJygvCaQ9U0=;
        b=wr+Ie0spcxh4Bv+k9aVgdxhqSj7Z27F1V19GqqD941LUo7RLXTrJ3dzp1adtvMyl5N
         aT7rNv0typ9DeKS5Tk5NP7Umg+yXyTkhrlVMwR+mV2oLxVO4oUdx/fZKWxAUToXnOgSh
         7yaT2Shrwz4jZVd83cPSLV7dVxfXDSz8y4zsl87asKz2Unplpl+372NctpFpWqDqjSCE
         5rGfL+qHgLMWbiJY+r3veQ/rDrnCe7m7lYNwx7HB/EVgdeH6xd5S4Vfd5vIW4AEzca5X
         I9IG60Pj7wgRKwojQ30m00DH+WFvpC4JNWDjTCy+Jp6gVuu7NMHWmX/Vfvjbp+9JKTuR
         LS/Q==
X-Gm-Message-State: AJIora/tDjIFaNtz3c7P+C6wd2FyW0XvpfvgIAnwFOjzdifp98wjLLIs
        1WcNhk4btA9XXnCuxPLlh4EfVg==
X-Google-Smtp-Source: AGRyM1tZjKVMWuD2n12LJ90FJHY8IZsKaQrHl5SuVWznr1RNc44Ebbb9J2BH8KdkKZspCJ0XQXgm5Q==
X-Received: by 2002:a65:4907:0:b0:3fd:bc3e:fb0a with SMTP id p7-20020a654907000000b003fdbc3efb0amr1155392pgs.123.1657682348898;
        Tue, 12 Jul 2022 20:19:08 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 77-20020a630650000000b0041299ef533csm6846318pgg.41.2022.07.12.20.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 20:19:08 -0700 (PDT)
Date:   Tue, 12 Jul 2022 20:19:08 -0700 (PDT)
X-Google-Original-Date: Tue, 12 Jul 2022 20:19:06 PDT (-0700)
Subject:     Re: [PATCH v3 0/4] Add PLIC support for Renesas RZ/Five SoC / Fix T-HEAD PLIC edge flow
In-Reply-To: <92a45bf04cfe140c7605559fa3d8f4eb@kernel.org>
CC:     samuel@sholland.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        prabhakar.csengg@gmail.com, sagar.kadam@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>, guoren@kernel.org,
        tglx@linutronix.de, geert+renesas@glider.be,
        linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Marc Zyngier <maz@kernel.org>, davidlt@rivosinc.com
Message-ID: <mhng-60d46fe7-e88d-43b0-9cea-a4ae865baeb4@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jul 2022 07:28:48 PDT (-0700), Marc Zyngier wrote:
> On 2022-06-30 11:02, Samuel Holland wrote:
>> This patch series adds PLIC support for Renesas RZ/Five SoC.
>>
>> Since the T-HEAD C900 PLIC has the same behavior, it also applies the
>> fix for that variant.
>>
>> This series is an update of v2 of the RZ/Five series[0], and replaces
>> the separate T-HEAD series[1].
>>
>> [0]:
>> https://lore.kernel.org/linux-riscv/20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>> [1]:
>> https://lore.kernel.org/linux-riscv/20220627051257.38543-1-samuel@sholland.org/
>>
>> Changes in v3:
>>  - Add a more detailed explanation for why #interrupt-cells differs
>>  - Add andestech,nceplic100 as a fallback compatible
>>  - Separate the conditional part of the binding into two blocks (one
>> for
>>    the PLIC implementation and the other for the SoC integration)
>>  - Use a quirk bit for selecting the flow instead of a variant ID
>>  - Use the andestech,nceplic100 compatible to select the new behavior
>>  - Use handle_edge_irq instead of handle_fasteoi_ack_irq so .irq_ack
>>    always gets called
>>  - Do not set the handler name, as RISC-V selects
>> GENERIC_IRQ_SHOW_LEVEL
>>  - Use the same name for plic_edge_chip as plic_chip
>>
>> Changes in v2:
>>  - Fixed review comments pointed by Marc and Krzysztof.
>>
>> Changes in v1:
>>  - Fixed review comments pointed by Rob and Geert.
>>  - Changed implementation for EDGE interrupt handling on Renesas
>> RZ/Five
>>    SoC.
>>
>> Lad Prabhakar (2):
>>   dt-bindings: interrupt-controller: sifive,plic: Document Renesas
>>     RZ/Five SoC
>>   irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
>>
>> Samuel Holland (2):
>>   dt-bindings: interrupt-controller: Require trigger type for T-HEAD
>>     PLIC
>>   irqchip/sifive-plic: Fix T-HEAD PLIC edge trigger handling
>>
>>  .../sifive,plic-1.0.0.yaml                    | 65 +++++++++++++--
>>  drivers/irqchip/irq-sifive-plic.c             | 80 +++++++++++++++++--
>>  2 files changed, 135 insertions(+), 10 deletions(-)
>
> I'm going to provisionally queue this into -next so that it
> can get some testing. I'd still want the DT changes to be
> Ack'ed before the next merge window though.

+David, as IIRC he still tests on SiFive hardware.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Though I also wait for Rob on DT stuff (I saw the other thread), so not 
sure that helps any.

Thanks!
