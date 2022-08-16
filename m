Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53AD595DED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiHPOCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiHPOCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:02:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613BD90192
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:02:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s11so13588262edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fzP2NQgZqJYKRDX1t6xLZ4tBPZDpSneow1UcjWoKMPQ=;
        b=n2K8ihSCpPw+4a4A8ph+BqFPQ3fqVunte+rj+d8r1nZsvumLrZp5gSlVUM09a4+csu
         eJALVsbeR6mQENUEWohsfqNrrgmtuiLG41ucEzA5iDPquNVmyvy5AicINVsztZJTHGN0
         HSM2duWWn6m2RqnisXlHnTJqhM+vTzDcumDD1umOgurUJdbsn4I0XBQnBcj7sHFQ5bV9
         tzO0hjKvHDYBDfhF/M1g+I/sBSrKDGNXm8tuwWT33TdwhJwSnOwwVS0+IX32vMSHbneY
         i2L+z65AQ52Mi9XjSv0VD0DSwztm+OwYEkgreIBN+iTeOePHQlMwdzHmd2uG/6cEFxZq
         T6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fzP2NQgZqJYKRDX1t6xLZ4tBPZDpSneow1UcjWoKMPQ=;
        b=iSgmrG11zd+lcj2FOCN6QVyw00Dt4amTPmylTffgIdGcbD/K1k/FZoAVnIUqPknvNk
         c+d++ATNqpEWcWgm1Kk4/iXx5ReL6XRN0rQAiQVbcDlbaLxyyeEBYRMRACpY2CHyAdke
         1t0Sfo0AtzTsPae7JbhfSdDuxGULBv782vcbPeZ50o7vaIfvWq/4+znOx9EWmAikKBSn
         db6+V3X1w/HmKFKXwfGBDpbZOLtikbYUTqkU4+QD//0pgTO7U33qLCLMZxq9VfcfUJi7
         CpaQyDNJNmEQhdOGXQcn2enZIw/ST0qZCkZSHrNUu24OCi5owc7qeWPasuKh+oVQju2w
         MeUQ==
X-Gm-Message-State: ACgBeo0InM7j+17kbPyY0aBCzW0aoLJOVUZ7kenFjvxkR3lN3YSU6S/r
        V/PFhYTIGwiLUMRUPl8YzAT+yrr7KjUc8AEKySrTFV+XDo0=
X-Google-Smtp-Source: AA6agR4Vabpt+DN6t/1Exw3ucKd1y7AVm2YfLygo9JJoNkxXDVddXKfSiG4auaQhK8+Uq4IFK+vmy3lrEBqvbkX+DXg=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr12983777edb.133.1660658553774; Tue, 16
 Aug 2022 07:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220816130823.97903-1-linus.walleij@linaro.org>
 <20220816130823.97903-2-linus.walleij@linaro.org> <YvuYCO4uuw+O0PN9@sirena.org.uk>
In-Reply-To: <YvuYCO4uuw+O0PN9@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Aug 2022 16:02:22 +0200
Message-ID: <CACRpkda-Mcg+6-h+QQ8YOPceSWmBeBJSpD9T1J1d8SHxhQnogg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] regmap: mmio: Support accelerared noinc operations
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
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

On Tue, Aug 16, 2022 at 3:13 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 16, 2022 at 03:08:23PM +0200, Linus Walleij wrote:
>
> > ChangeLog v2->v3:
> > - Rebase on kernel v6.0-rc1
>
> This doesn't apply against current code, please check and resend - I
> already applied some other patches.

Oopsie I just assumed v6.0-rc1 was clean :D

I'll rebase on your regmap tree, just a sec.

Yours,
Linus Walleij
