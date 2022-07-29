Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5058533E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiG2QP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbiG2QPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:15:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CC387C3E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:15:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bp15so9358581ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xSDRKdty0wVkW61wac2qSe+OPKhy9z0shDqzar+oq7Q=;
        b=ASxKkckqlu689PUm9aVQf4rXt8iNyNs0+RXS5aXwLWKCu4pMOA4Y2sVVoWd/6zslku
         dlqNFhWRzrGRPKULDttldYsRGokq2bQCOR6wu9chv46+t0/kYHLZVnqhZQiaGXt7Gi+u
         N8ZCSg4QxeAxsVo9W8UEWgGRptHIaQMcp7Z7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xSDRKdty0wVkW61wac2qSe+OPKhy9z0shDqzar+oq7Q=;
        b=zjRg4C2H40wUBjkaTbyD43RzPZ2vLqQrgKL/p9jopM3qxdrOqhfnd3C3GKsd9E9ti2
         W47PSQr9pAM3QiBbayqbeH71aECrtpr/5+DR2qVLhZMmaTyrNppSuumvoMMUye5mnv8i
         1TLhEkzOowZ2WBi2EobOU2X++tSrmpoe//eYcwaHqekLR/aiaDlNtg2B+I56zCRpxAiz
         g1TAhtyKGGClh4H6Vg3thvZGU4YjOnIhx0NqPvq8k28B/kunL9UEUBv6TipAfVCJjOpu
         p91K8lk5dNT1OMEtfFJZwwOZhyOCj5vOxMGdQIqwFfWmnYYrsL5VRrK/qdgBYHjfy0bh
         0+7Q==
X-Gm-Message-State: AJIora+dJeCBpmadHgah76D+w82LU8htLgmfVG29uNNQJxdZg77Fc3hL
        XmrPmIiANbftC59K4K0fuL9lU90XNm92TgNW
X-Google-Smtp-Source: AGRyM1vrFfhgP7pWjCjOWqUEXxJy32fdNkDp3+QzUEkndmSRxc29H04D65X7OWFirwHGeqmOw1kVsQ==
X-Received: by 2002:a17:906:cc11:b0:72b:458e:5d45 with SMTP id ml17-20020a170906cc1100b0072b458e5d45mr3434497ejb.589.1659111349233;
        Fri, 29 Jul 2022 09:15:49 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id kv18-20020a17090778d200b0072b33c0a831sm1892016ejc.17.2022.07.29.09.15.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 09:15:47 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id q30so2175335wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:15:47 -0700 (PDT)
X-Received: by 2002:adf:edcb:0:b0:21e:d043:d271 with SMTP id
 v11-20020adfedcb000000b0021ed043d271mr2960016wro.274.1659111347424; Fri, 29
 Jul 2022 09:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3GTzeJUdcjVv-1fL7h7e6XRFPA65-5xseQ4=tyZE8UDg@mail.gmail.com>
 <CAHk-=wgdnnAmDopTKXbS5u3Ty8GgAfuFOSOycsCfe6pSAqunHg@mail.gmail.com> <CAK8P3a0L24AxQD_72bHYY7CKvnvcYi4e_+Zq_n6KqWXzD7-G9g@mail.gmail.com>
In-Reply-To: <CAK8P3a0L24AxQD_72bHYY7CKvnvcYi4e_+Zq_n6KqWXzD7-G9g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jul 2022 09:15:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPm7q4ikoErhEn3dgGsO_-RSyYuRYox2oHp+Z0z8FUGA@mail.gmail.com>
Message-ID: <CAHk-=wjPm7q4ikoErhEn3dgGsO_-RSyYuRYox2oHp+Z0z8FUGA@mail.gmail.com>
Subject: Re: [GIT PULL 0/6] SoC branches for 5.20
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Jul 29, 2022 at 1:15 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. I'm missing 2/6. I don't see it on lore either, so I don't think
> > the problem is on my end..
>
> I got a reject from the mailing list because of the size limit, not sure why you
> didn't get it though. Sent a smaller version of the email now.

You resent 3/6. Which I had.

It's 2/6 that I'm missing.

                  Linus
