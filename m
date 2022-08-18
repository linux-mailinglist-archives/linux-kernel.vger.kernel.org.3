Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD702598DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345694AbiHRUV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345773AbiHRUVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:21:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47A5C0E48
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:21:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so1514038wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6pkHhD3b4s4v8AQHs/WwRMbCrj+baLByguJdX3yP3tE=;
        b=SNg7c5ehYit1W3JUTfCcA1hj7RDAY1+SiK6sTMnKJidiwTgVb3c5eZKWvLF7K4IwoD
         sccQU3hBb2AumVwC7SLf5xvrKlUo1+B67NRu8XntVU6o6grLjNyHOGYJkQoKiVSXN7/M
         1eeIeywiXbsVYr58Pk2PhqcVQJZct38rVgOwSN2fCsrJi6WhArQSESCPNKKMZTSCITYp
         fsZucnwY4o0TRfbfCML/PrKlsVsJzRdjGf0g4SeWeYlAGZ2flkVg4bgodsKFvj/Y3C+p
         vsvmYIN1lUQjldodmNJuMS3eak3vEO07PINmkpZXdJGEzHkLIVOUzm8zgwaTl9bVNq/f
         0eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6pkHhD3b4s4v8AQHs/WwRMbCrj+baLByguJdX3yP3tE=;
        b=LSQfzg6/HRv7stWwJjxT/bU+uyeUQ/IwN24sEMRs+xWmsB8X7lLEf2zYC8SJcGYTN+
         1VLEjgIgG/uUllTxjW0PGjeVBk/6TkdL3Mxg4MUCiLrqmLeWZ6nBol/nnI3OaLyWhnoc
         QSl1vM6qEPva/LaBSmR0d0TQbBK4GugsKhT5CPHnsneNT9ka9lWXNTvs7lHTKNqpSNBj
         0FUN745I3IcgSKRlJ++E12T+Vx7ncuhS6aDR4QBFVMmy/4kfNpNTTUjeRrznIgvhFGS/
         9X/vrhYRUaiWpQEa7K4/QfnheyYQFlnt1Ryp450oiNJNO9bvZ9vUyNuGsY307WY2nH31
         6how==
X-Gm-Message-State: ACgBeo3+TKHxT69fBlRgxhtZ6uYVTtgfVXLX0ozjFEnEza8PpbwMQomh
        YgPE+8BckV9y2S0JvbSbahApR6QTdcDrhbJ0
X-Google-Smtp-Source: AA6agR6qGU/c5zIjVDM4u/3IHu4BiAu4VGjiPUqHmwqo6VHjdZvw3PlBFQMCeg5go3ZwXC9ISlkFcA==
X-Received: by 2002:a7b:c41a:0:b0:3a6:2569:7eb9 with SMTP id k26-20020a7bc41a000000b003a625697eb9mr2786229wmi.0.1660854077409;
        Thu, 18 Aug 2022 13:21:17 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003a5bd5ea215sm3121230wmj.37.2022.08.18.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:21:16 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/1] riscv: dts: microchip: correct L2 cache interrupts
Date:   Thu, 18 Aug 2022 21:19:49 +0100
Message-Id: <166085385179.1336923.6007777550886077496.b4-ty@microchip.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817132521.3159388-1-heinrich.schuchardt@canonical.com>
References: <20220817132521.3159388-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 17 Aug 2022 15:25:21 +0200, Heinrich Schuchardt wrote:
> The "PolarFire SoC MSS Technical Reference Manual" documents the
> following PLIC interrupts:
> 
> 1 - L2 Cache Controller Signals when a metadata correction event occurs
> 2 - L2 Cache Controller Signals when an uncorrectable metadata event occurs
> 3 - L2 Cache Controller Signals when a data correction event occurs
> 4 - L2 Cache Controller Signals when an uncorrectable data event occurs
> 
> [...]

Added the impact of the bug & applied to dt-fixes, thanks!

[1/1] riscv: dts: microchip: correct L2 cache interrupts
      https://git.kernel.org/conor/c/34fc9cc3aebe8b9

Thanks,
Conor.
