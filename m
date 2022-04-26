Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2F510A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354930AbiDZUfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiDZUfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:35:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA42A717;
        Tue, 26 Apr 2022 13:32:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k27so8583489edk.4;
        Tue, 26 Apr 2022 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCJZhZ8JOCOzJDroZy2k47OUeMRvL82ynH0nIu7m01o=;
        b=iXXkzKNsoPSKLDrNUMP8yKdEuEFTfbu0tyFT2G5AU6YFrPEZoeocyPafPF8ZIlRVs4
         PDrkFym8Crg0f43QRIYFU/4GxHU2KGz+GU+1cEu6Rf9VOyXqJiePa+MGXIgDHlbWbRBH
         N4ghHy/zZsz8p09CRq01YFG9BPpRa2J4KWHWVYU/+aRmxtxh3nHt5W5bG12rrlypJq3U
         VmAzLAmpyBvhats/QPX+mHkTHSKnKdgJoZ+8/Ybz3x9mI7h79Pmeq8gIGiPBP3CwSO0S
         MNyDMrFi+6zIdS7OFNZuQFB+vYKSFA0bwRkUukkfHiithWp2mC7Ar3kIx5O6c3Djah0Y
         ZwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCJZhZ8JOCOzJDroZy2k47OUeMRvL82ynH0nIu7m01o=;
        b=vM1dRZB7LtNaovvVJEm7TvH7wZXxapMWnXwlS4COuFb48/7osTmSvNZUU9SYRc3jh0
         Uk41UATIwcNGnJ5gaN0xCsYkgmHaMbmHMHKx7WThA1Ww3z86PV3fa2rsOKeIIl0Qp+92
         qwX6aKOTEpUhwC6CXaVn7aJzuRfcUQlfkCdm01wPTlRdqK1lZGyqMEkXJq5PVrAzvSjV
         gufs6GGXRVcI/uQriVGMc1p/b4/2/lXGy0d1/0GLltzPNE4L8tk+ayhjQ0Ko9U/Xffqb
         SLMtC03Ixaagt8LjchyyzV9p3at8OETQvuz40nMCuuXyOpuTuhVGgV4cuAjlMuI0Zr/5
         sUlQ==
X-Gm-Message-State: AOAM533i40Bv5hdzbUJefvegio5+1fIj0GYRCvw5Y/UOazQqqG9X9TXV
        OaNKQdgnqqcumxYqmOsOyd3bdXNlcmi8uXoTCo4=
X-Google-Smtp-Source: ABdhPJxM9ois9zrxPnY0Yglv8Wmwye6OZkLgME14cU+BM1xzqoRFJysfsEUURBF/17qdpY07NDekFmJ6BqLkcCFOIfE=
X-Received: by 2002:a50:ee11:0:b0:425:b5b3:a48d with SMTP id
 g17-20020a50ee11000000b00425b5b3a48dmr26701096eds.246.1651005127954; Tue, 26
 Apr 2022 13:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220423212623.1957011-1-Jason@zx2c4.com> <20220423212623.1957011-5-Jason@zx2c4.com>
In-Reply-To: <20220423212623.1957011-5-Jason@zx2c4.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Tue, 26 Apr 2022 13:31:56 -0700
Message-ID: <CAEdQ38G+FeEMJ7a1+0Ay_d1e9mG+CUYsR6EABRXDn2j0smMSdw@mail.gmail.com>
Subject: Re: [PATCH v6 04/17] alpha: define get_cycles macro for arch-override
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Matt Turner <mattst88@gmail.com>
