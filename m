Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECF4F1E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379970AbiDDWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379470AbiDDRLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:11:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE1B13D16
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:09:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d5so18487055lfj.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqfahCfQspBfoK65a4hfr+hSofOu1wW+gpiKNcZisYQ=;
        b=biW4T4KbcnBUKe0V+odxlHEjPidwu45How8OVgfeUkCpUjNCyIK/YwfVb6wbHbAqgq
         U0852oL6QhdYowEUdxOyhcPL6qxZGFbYohWnK59WCeg4BAM2fc2Lj7MGqfc7AHjkYqJL
         GPbLMXZXE8Jdq5uRMGsJdekbOICtnWQ5IZp14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqfahCfQspBfoK65a4hfr+hSofOu1wW+gpiKNcZisYQ=;
        b=bKHDEi07caIxFuuLGlXeg33FAljmtVPQBFIPrQk7ul/M2RJD7NQ7nkXtOh8TQ5byPj
         piZ0hYqEcZlOnxRAdw4GdZ63oRHbo45lmCI+dDspUCXmPpqFNY8bPEBeVE3nkM59jFaI
         qb4oCONo2zeoEzozGjWqhc/kOVhl7hcqX7Ykl+sgiOe48mjCaCOdBb7qdKOE28FTC6cA
         1B7KyP2bRPWhAYeLKyVmggdAELRjgT1MZYlZL2jsyaoHLjvok8Atwr1XLkdrrscXZKnV
         NG411kN9aZTYQhPkr7RZfl4+/cEDahHB9w1sxdS3UOb6Wq4W3vnlvU5VRa+YEKt2eDZs
         xy7w==
X-Gm-Message-State: AOAM533t9VydCp40LmyLza3DjxaL4KfK3GvfrjsoaW16LnS6cBJyV01P
        waYhjmA6KiXtCddyzi9mAH2Nf24swNG/3GpX
X-Google-Smtp-Source: ABdhPJymaKb024Frng4tTYJFozUp/bLMX4HXfAaTxBSeYmLDFKGBkvgMykb5XOefSRNm5Bza7X9vpw==
X-Received: by 2002:a05:6512:108e:b0:44a:7147:984a with SMTP id j14-20020a056512108e00b0044a7147984amr326905lfg.220.1649092189291;
        Mon, 04 Apr 2022 10:09:49 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id d25-20020a194f19000000b0044a2ad98dcasm1192124lfb.167.2022.04.04.10.09.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 10:09:47 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q14so13732787ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:09:47 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr358339ljg.291.1649092187476; Mon, 04 Apr
 2022 10:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404022239.GA1186352@roeck-us.net> <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
 <aba387bd-9799-e0b5-40e3-1bcb552ac74c@roeck-us.net> <CAHk-=witgMUS8To6wijxdbQ+QEH0gcHSYV6Y=yzOdb=Q4h9PJA@mail.gmail.com>
 <ea840ab9-0c20-8c06-f7d4-bb9642a63500@roeck-us.net>
In-Reply-To: <ea840ab9-0c20-8c06-f7d4-bb9642a63500@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Apr 2022 10:09:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheNvagyYfd1HbH80tysHtJtifDbAwQW9S_Ye+6YZU_uw@mail.gmail.com>
Message-ID: <CAHk-=wheNvagyYfd1HbH80tysHtJtifDbAwQW9S_Ye+6YZU_uw@mail.gmail.com>
Subject: Re: Linux 5.18-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Oded Gabbay <ogabbay@kernel.org>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Mon, Apr 4, 2022 at 9:45 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> I tried to tell my provider, but to no avail.

Sad. Email providers that are clueless about email? Incompetent.

             Linus
