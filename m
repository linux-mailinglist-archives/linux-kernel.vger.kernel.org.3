Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4FE52C85C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiESAHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiESAH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:07:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C223210570
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:07:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i27so6815567ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYzl0vkutTLS0hzlFyrBMzDRdY+ph8j1AYEXBHgldcg=;
        b=KwKF8C+a3lYh7TKvVdu1n8gevRU2AzOmIvfDcMSy+DEdFmcWxwGeh1VxE3LilvEONC
         qKpj+AgORGrTVnZZiQkvAlh1SKWihwN9cKUyi295BuJtRpF3FRCTEtQ9y7GyxQTgqSMr
         VF4oqiBd6OtNQIjXTjPxogigoRT/miEr7g5Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYzl0vkutTLS0hzlFyrBMzDRdY+ph8j1AYEXBHgldcg=;
        b=X95XNq5yrPAtIGSTpsxisef1CQHWW4HRuSydzuCFKwVqP29DKkoyGwOw7ygLt5SQpZ
         vWvBDwCVrIqjhBVc71AFheL7WzXJUjKLn8u5GUYfbS0P2J/vZRl+JHyPwLuX/xEbrZvG
         LWbmOSMpwngdMXlXFUZM1OJKpo7uxZSK9bv4xWQCQBolmLKF35gpqvJaEY8pR15SeBGz
         i5W8/YJFeu2I801TD2YRza2r2sRQ0n6mqteBo/pO81OVSgDUm2NwD8vTfNtiGs5IPtCC
         BnWV384anbXK30vcYBnDbODUVvLsM4XRUkSIdvKQPaoNuvQyYzQhc6ao4IigcOvKQDZn
         2Z9w==
X-Gm-Message-State: AOAM530Zr09mlnpGdngVknnCwYmPVX4lFiZ+UZMbwjcGBK2DGsZnU42z
        olkIZFvH7Eaj84HSrBnVMLPXytdoxn0qNA==
X-Google-Smtp-Source: ABdhPJyPBhD611JXdFcQQIK9WQpvXrzkZl1MZrUjKQreeehXXe0Z/pS6/IU5dNfrQBtmXOpZ+wVKIQ==
X-Received: by 2002:a17:907:868e:b0:6fa:2fe2:92d6 with SMTP id qa14-20020a170907868e00b006fa2fe292d6mr1816564ejc.639.1652918847085;
        Wed, 18 May 2022 17:07:27 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id e18-20020a50fb92000000b0042ab8c5e99fsm2064536edq.14.2022.05.18.17.07.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 17:07:25 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id t6so4869698wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:07:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2c2:b0:20c:7329:7c10 with SMTP id
 o2-20020a05600002c200b0020c73297c10mr1658727wry.193.1652918845040; Wed, 18
 May 2022 17:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <YoUiHhz1NsTbN5Vo@zeniv-ca.linux.org.uk>
In-Reply-To: <YoUiHhz1NsTbN5Vo@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 May 2022 14:07:09 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj4eF-HZc+uuVcD4EjLW_QN7_8OZ5gtAC9_6qY1-ZK4rg@mail.gmail.com>
Message-ID: <CAHk-=wj4eF-HZc+uuVcD4EjLW_QN7_8OZ5gtAC9_6qY1-ZK4rg@mail.gmail.com>
Subject: Re: [git pull] a couple of fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 6:43 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         vhost race fix + percpu_ref_init-caused cgroup double-free fix
> (the latter had manifested as buggered struct mount refcounting -
> those are also using percpu data structures, but anything that does
> percpu allocations could be hit)

Pulled.

I do note that you are one of the remaining people not using signed
tags. Not the only one, but _almost_. I've cajoled almost everybody
else to use them...

               Linus
