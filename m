Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4822A4FF2FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiDMJKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiDMJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:10:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5EF47AC1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:08:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m67-20020a1ca346000000b0038e6a1b218aso748377wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcONJnYI4hzfAnWFiwecQemmmPoFQyWC52bLjUUOhrU=;
        b=C2A0UxLCik2RA66J4ZxU8ctZ/aw4YcYRTXGVm9HyDjtOWT0Bn25s55zjbACnN6vpTY
         Y6sLVRjED/jhSIQrh0rna36qT3pmCF//OnTMjDlataZMQIcCuUZ1quxEX5jwdsNdOQ/j
         Z09rc92UYJIp9JUy/q1S92YX33AaWq0n6pK7yV+6tcDOUgviPs3bd2kyg+5x2K5PBiTP
         fl3qaJ9GioVeJRagF2rNIPp3EB6J05yTAlrsyRZesIGLsrIQSlYhKAul7767YybQ0C50
         YDZ+bd4nErjZTXNmqTic4M1kdTgdLHbDtUgNIY2etG8k13d/z2U+B7rVXeoAvweW1DJI
         CkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcONJnYI4hzfAnWFiwecQemmmPoFQyWC52bLjUUOhrU=;
        b=8Do/518W1qOf3RCnTek/ZvhF6yWCYjVYZSN1yQMtBPDCIih06uPptuhStyCLUfZfnH
         vPjC6k7eqdxymW6j6aax8NthNethZB/Gi3DwMyfC/ug5B2qz3j7yVaJyUZunu4CsyaBH
         1vuHrAtmRgEOrTSGaNEmeV6IjXJ9nhuV5nltrbEkkHL4N36qWKCcQiWox6WgulxUaPIq
         Auf0tJhHopg9jN5FLDjMSA7iMoFYyC7iB8xFh9sXmSFCuit43c69oAhKa8i7IjoVwdw9
         zYL+na3UBgnhIwGUaAp2mrS34ea5dUGu4cGYqOtbKhWKpgRGNV8wfG4ZdEJs0JnaR/Wz
         SI8w==
X-Gm-Message-State: AOAM531kvKiIaFK/YVyWZZh6C7XAF+kY8wRsbwb0b42WtPE5WkTj3XBq
        tpQ07243IE0loCJ2g/bJLFdoOlOfZW0c4oVRC4PJlQ==
X-Google-Smtp-Source: ABdhPJzSxXBk+5mekTAuDVmri1mQi8I7f+bYDh99NHFWD3CXOjiXY2xxY5gTJfwTdzd9TpeYBmUYvQ3dF4xNbswSc0E=
X-Received: by 2002:a7b:c20e:0:b0:38e:b9d6:211b with SMTP id
 x14-20020a7bc20e000000b0038eb9d6211bmr7934373wmi.188.1649840902444; Wed, 13
 Apr 2022 02:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-5-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-5-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:08:11 +0200
Message-ID: <CAAeLtUCK8eow4rFmWRUVHhQjpZzhiXrR+49sS6-FjtoHpafR+A@mail.gmail.com>
Subject: Re: [PATCH v9 04/12] riscv: implement ALTERNATIVE_2 macro
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
> When the alternatives were added the commit already provided a template
> on how to implement 2 different alternatives for one piece of code.
>
> Make this usable.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
