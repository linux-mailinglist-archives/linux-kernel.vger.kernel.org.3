Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8F54FF2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiDMJIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiDMJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:08:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AFB4160D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:06:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m14so1633511wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4Ur5FuAMtA6xVJsN+nl3/RAKHtJZB/dEjqv/D42SDM=;
        b=E9zncH8fDX4akfa0q887+k3HgURcftW3VOd3P3DKaRcVVy5WhbTBD846cDePAP6rPe
         +w3Ttm3WFE/HtZ9nxnTqGKlzE2nQx0WSKNbmb1UcCDOv9yhUt5WE2+Oy6n20B5S7sNWj
         PINcVdUSSIKc7BTpjDCBRb7h5SKl3EP9tpmiUon0I1W/9LqH2gQTqTtJnGTX0G7sJhFe
         1TyR2T8frmfmVy+Db9tV5J2zMjlCaTJeQAgw+Meb6bniNWCKiGyWGFJbsiSYupheLcJ0
         VyegBwqX9QvW5oOtzoSbBhqqjkZOs5rl7GNp0bBPOwQhDJ75+qI6HFAFhnsHDPxIDAmc
         MS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4Ur5FuAMtA6xVJsN+nl3/RAKHtJZB/dEjqv/D42SDM=;
        b=LXs7hoCMzJIS2nqLbNk0n5r0WMm+2PEtw7OxCwwEo9zNLW4dxdYrUOnBoWZtr2BfVL
         KWKCR5EX9il4XjirHrybJ9/6/PCjhRGqv8ZJRUOv3vQJV9oQ9yAieEMtOBAOKmAmsdke
         ZQnitoOMRh1GxDlo7EYRlmThzjllXvKJCrxVh/SlWE3B88f1TqRag6UIVGg/pqxLpaIH
         gO8SmLbsg3ISvuj0iu4RLYus3sz10ndThKmxIPGz+upC0Ixf9N3+gmYNgqq41xuEEXhe
         BBIVK2IALYqhSH+6mzdzWRkK6ppFUD0Bwj9+2vwhzZKyWdDPX1gdSvl8JfztyrZdo+sR
         it0Q==
X-Gm-Message-State: AOAM532xpPRvdhOsG22cM15cR6NsNnb1Y6UqbnCTVyKSHdlIFbHB86Fv
        bE81FuDaVWOpUJMJearMwMFzc7KhKdhRceIV1gpxLw==
X-Google-Smtp-Source: ABdhPJyIwwxPJ6LcuXM9IBchpQCcd3b56k+vDKmb4JRXyHcSQ1I6icydynMFl1ioG+SUrUV6KnvsJSVwMsPbpOLncK4=
X-Received: by 2002:a05:6000:18e:b0:207:a221:302c with SMTP id
 p14-20020a056000018e00b00207a221302cmr14318339wrx.120.1649840761707; Wed, 13
 Apr 2022 02:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-3-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-3-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:05:50 +0200
Message-ID: <CAAeLtUAiF+d5Yj0Dak-hiCZVGe1zSU0k=E630n_BOXkutg6jZw@mail.gmail.com>
Subject: Re: [PATCH v9 02/12] riscv: allow different stages with alternatives
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 at 05:03, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Future features may need to be applied at a different
> time during boot, so allow defining stages for alternatives
> and handling them differently depending on the stage.
>
> Also make the alternatives-location more flexible so that
> future stages may provide their own location.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
