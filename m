Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9324610A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbhK2JAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:00:07 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59044
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243520AbhK2I6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:58:00 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E38214000A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638176082;
        bh=+cIyWIIE7i87hR1qslQO4QHxm41aJn/0jtncJRQ6V2I=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=GZ4/9yuA+9jPjdcXr5XCzevPVFeFpS1oFRzUyh6iY1nqLzoS9GWgJu5lVjtKxZs7V
         4L7vW39LgTeE/Ved+pSnYtyFBJlVUwsy3DjX1hMvAL0E6yTtZCE4H4na2dOun6/8DL
         5tpAlQjKaO0vzZJuMYm0baG6s/svXcL0NekWUNOn41H+xw99+TkY43Pa/z1AJS0iCg
         gK33Ve463F1LCy4DO2Dpj9jsZkOgiDZVHWfM3tGwVyh5HLuINMiA9gYOYqreP3Jyql
         +i0AYWKwK60+fH6gj/a0sS/4MSDYvWFjkSkNVkcUXn1Wbs9YIEESz9NR2Nk/e6m8rY
         lVkf7/wj+vbtA==
Received: by mail-wm1-f70.google.com with SMTP id b142-20020a1c8094000000b0033f27b76819so5388781wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 00:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+cIyWIIE7i87hR1qslQO4QHxm41aJn/0jtncJRQ6V2I=;
        b=OdEc4DPt+9yhQ/CqlBXJ94qNKn3FnRBk1qBvK6iYZfxNeSE1pMw87CP45+Fl4NDeSl
         YeKoGgX8lXRGcjYuZPHfhMdbHUmOO0tt8pmbdpJtjsrbPfQL7zBC17BxnMfpn/zi1DbX
         EBKxmq9o99m+38TRcp4KVahWC5uV0DgNtI6LW3lkU9vQVrduL2eK0ypewWDjuI8OiOz6
         lYKzNY3FmbWFK+eC+VTVMFieG2i+hPdgifPmJY2/YuyTfCnBxZUaVGgpgrkzwsi3Yz2B
         vBdJqS6CJX6ZEkyYtmnYf6RRq9jmxPAYnkqRD5BQwXx8wN4HeNVAgNBrijjyWkrMKCgx
         WcNA==
X-Gm-Message-State: AOAM530CUTJmJ5lK2GCL8JGNP4ZS38hUnZ1RGpzv5DgmEjlTMLANOCmI
        70NMfDCVY09ZjQfC29Q1wpTHoEAeeC4wUYc3vu59YaZPt2p/XS2tt13vqjfxkIJ3tqw4kF2oYd3
        bEUIwy2DcYrnvsMTgKYP4j+7/y1dfZX4PtZ1ri+yTwA==
X-Received: by 2002:adf:dbd1:: with SMTP id e17mr32019322wrj.480.1638176082359;
        Mon, 29 Nov 2021 00:54:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5iHsTpnNO012VAWrcN7a2oQNs88jJzbfoGr42p3pu8vfwhrpau7QH1zWWIbpBuF3IZjaRnQ==
X-Received: by 2002:adf:dbd1:: with SMTP id e17mr32019289wrj.480.1638176082157;
        Mon, 29 Nov 2021 00:54:42 -0800 (PST)
Received: from [192.168.123.55] (ip-88-152-144-157.hsi03.unitymediagroup.de. [88.152.144.157])
        by smtp.gmail.com with ESMTPSA id m17sm12760100wrz.22.2021.11.29.00.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 00:54:41 -0800 (PST)
Message-ID: <97431cab-d67d-4bc7-e181-d64534791f03@canonical.com>
Date:   Mon, 29 Nov 2021 09:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
Content-Language: en-US
To:     wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        gordan.markus@canonical.com, guoren@linux.alibaba.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh+dt@kernel.org>, anup.patel@wdc.com,
        atishp04@gmail.com, palmer@dabbelt.com, guoren@kernel.org,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu, hch@lst.de,
        liush@allwinnertech.com, lazyparser@gmail.com, drew@beagleboard.org
References: <20211129014007.286478-1-wefu@redhat.com>
 <20211129014007.286478-2-wefu@redhat.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20211129014007.286478-2-wefu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 02:40, wefu@redhat.com wrote:
> From: Wei Fu <wefu@redhat.com>
> 
> Previous patch has added svpbmt in arch/riscv and add "riscv,svpmbt"
> in the DT mmu node. Update dt-bindings related property here.
> 
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>   Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index aa5fb64d57eb..9ff9cbdd8a85 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -63,6 +63,16 @@ properties:
>         - riscv,sv48
>         - riscv,none
>   
> +  mmu:

Shouldn't we keep the items be in alphabetic order, i.e. mmu before 
mmu-type?

> +    description:
> +      Describes the CPU's MMU Standard Extensions support.
> +      These values originate from the RISC-V Privileged
> +      Specification document, available from
> +      https://riscv.org/specifications/
> +    $ref: '/schemas/types.yaml#/definitions/string'
> +    enum:
> +      - riscv,svpmbt

The privileged specification has multiple MMU related extensions: 
Svnapot, Svpbmt, Svinval. Shall they all be modeled in this enum?

Best regards

Heinrich

> +
>     riscv,isa:
>       description:
>         Identifies the specific RISC-V instruction set architecture
> 

