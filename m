Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950B6507252
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354117AbiDSP65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351075AbiDSP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:58:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623AC237DF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:56:10 -0700 (PDT)
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfqCF-1o9Y7F2teT-00gEG6 for <linux-kernel@vger.kernel.org>; Tue, 19 Apr
 2022 17:56:08 +0200
Received: by mail-wr1-f49.google.com with SMTP id t1so23068725wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:56:08 -0700 (PDT)
X-Gm-Message-State: AOAM530J4iC5qoKmZl+bhVs7pO0E0QLHjjcIOqMPkonZ+WeQLeACc8B9
        9ZnTF/Y7/ug3JFFxeIsKahvt5VKUnJWgOcJ9tjc=
X-Google-Smtp-Source: ABdhPJxNIyESz/EVgCAypLtywVxRPvsQ8wXEzf0J1Ebj9gCD6DgIxC5lVZ/hv26NhvTTi3jOvV6qDowOWFJ9AsDuCuU=
X-Received: by 2002:a5d:6983:0:b0:207:a226:df4b with SMTP id
 g3-20020a5d6983000000b00207a226df4bmr12207718wru.192.1650383768397; Tue, 19
 Apr 2022 08:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-33-arnd@arndb.de>
 <87d0egjzxk.fsf@belgarion.home>
In-Reply-To: <87d0egjzxk.fsf@belgarion.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Apr 2022 17:55:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1VfUqBZo_CMukwsLeb4pqg2C9i5mqG1KXaK8EpLAOc8g@mail.gmail.com>
Message-ID: <CAK8P3a1VfUqBZo_CMukwsLeb4pqg2C9i5mqG1KXaK8EpLAOc8g@mail.gmail.com>
Subject: Re: [PATCH 33/46] ARM: pxa: pcmcia: move smemc configuration back to arch
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6gUaDHSNhIuN3JqRKBOBlXuWEzqKDWyaas8K7x5kulOP8mEw4Js
 VqoDD2m9zefZiOPb2Yitq56JJpuxM2muTOox9h4r8tc1kuMOTJuodzlHVfg6BHVEfBk2AZn
 AMvPn+QWftWRDnrMHGn6Th0KFqKYVBcfUNZmTJQXxhfpkPAHmlE3PSlPZcyqygQRE8vY8vW
 Q9rK2tjdPYpOHcSzkKlWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ui0cDskGqH8=:Bxt57pLUfNfeEuXvE1oysQ
 xzbbGOx0O1gmONDnfdYXolFKIEqm8JPwpbtv86EHR/sWGZ4txWKp7VMnEDC9ckmGj7R0CyVVb
 46VWWoIQBLk6Z44RMFpGv7DaFpssppRiKKZleon96ap576X9Gm8DzYfYrBTpk7QFdJ3SyHYfG
 pSvoXU43MmCxweQC2dowE5Mw/DVhfRJWB18maK34+TXnpIu4Qxo0Q77vUnUEzyO+en/3gtXM8
 GbBM+c5aKeUG1Nyy+6wbDGcJJ+OGloi+deNtKLWCrdynpz+Raavau8WcTd+mlDmF3oY/9mUC/
 i8Rzwgt3EZ9DFBVaUjIIOmdf1viYjfkIHBY347OFK/Gu0NjDzE8JOP5c5RU+r6cNrXwekZQky
 dECeVnEwaXbz13mEUAAmRwExINAXu/wJjZJkM7IOcEnyMX+kgfdql2qT38HffpcbUmZlhtH0c
 aTr/VM6IpnLSpX2rIs0BF7v/WZz09sVFUv3kEzW2M0fbhbwWHdiWUm+5qxduppGKIorsbwBfz
 LAAn0WT7XW2l1coV2i/4WCKsG44mLDANBUd/nmznc0jUdcdcPOt9xSQ/Dpk/p07Zh6B+ZGuCX
 kpDCzv+hC5tM/6G4H3bt6xtnTO4OWLj0wD8yGSBeOX0i0jGWsh9+XHV4/Ns6D4jCxoFs+6udo
 uD1b2PP4N0w3/xK7sTBowZbGxX7G46XOlcGXvuiQkJF9zCk8fj5tVzduIrsXfuU67WpdDuGbZ
 9AQMHISh5RqQrM24lchiUwOBoWCJ71eFbhOQgXmHW1J2WpTQYbq/Uj/gsmLPUJN0KkCqJk+sP
 otHaDoaqQEyNpTnnyGlR+FLamkBeEsHSXMru6mJu5/BvQhWCZw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 10:58 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> > -static int pxa2xx_pcmcia_set_timing(struct soc_pcmcia_socket *skt)
> > -{
> > -     unsigned long clk = clk_get_rate(skt->clk);
> > -     return pxa2xx_pcmcia_set_mcxx(skt, clk / 10000);
> That curious, because you divide here by 10^4, while in the old
> pxa2xx_pcmcia_set_mcxx() that was 10^3 ... is that a fix I don't see ?

Revisiting an older patch here: I'm fairly sure the change was my typo,
fixed it now, thanks!

      Arnd
