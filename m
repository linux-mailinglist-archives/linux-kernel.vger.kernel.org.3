Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089425AC47A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiIDNVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIDNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:21:20 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DEF303E8;
        Sun,  4 Sep 2022 06:21:19 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id k2so6537866vsk.8;
        Sun, 04 Sep 2022 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zm+EyzwIQUGPDwFnMMoLTrR9COFLYicTA4/koBenuTc=;
        b=b6+N4hNrgd/gwbt5oOVeNZuwJR+TKHHQTg3dog//QrbCMyNOeDYTfcg02r/phrrZpA
         WClzq/CZsyp7IOzAaZ4rE2nXfo0mD3g/pt3tz65NSNlW9YHcdQKUZzzMpcwNt+qule/x
         VxB7mDGI/0TTcjT2rbGmlob/sfViC8FWwISqW5xHsXRFseBwkLWf1vVlhNH8ick5cYUE
         aT1IcwBnICVufrkheKnZkfsEc2BO0wtsZjvhOGV0bds5H9eCQO0II/hg83uWpC44Q+rH
         W+WrbCuVfZjvUassAMGNxjHfRTvGnLy1UvHVwjGkZ2vsvQKgkF7OgOf0xFK1+lU6UpC/
         6B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zm+EyzwIQUGPDwFnMMoLTrR9COFLYicTA4/koBenuTc=;
        b=z5AcCMpuLMSAV9GzlYmBGNnoVjZcUKYOiQ8MetqWMHTz7WRUxgqbiz5S9LAZ2Q4lN+
         5pJ//lduH6XqfapUqyTX7UM8XIqrxUQ0vbpbj0LKS7B3BlWquBJYsQaB6Jdvm2eQInBh
         rJAzDKMkVikdAaIvU0/sO5TVAMqmZ3nNBj8v3fzmrN4JqKpjZtanoFem6I6gSnfy/145
         38WWOWcKzAahmop3pGidTriK6EQSA9wkT6rSoj7YCMCB7MKqckhksiEScXGm8EVMFa9v
         icZcBCrYSMbevTtRI4xd2WJIhRKG/Z+1UYbTlQVKCGhL9m5lmVxY4jjFFWzFY6z4PJey
         zsOw==
X-Gm-Message-State: ACgBeo3I840KxQ46VLWEZO4TnmPLO5Kc1YqWkQahqiyktfhTmcYa+luA
        CpchoJVZARSboKrYYNeJhriL4MbJehhmG/iGsKgWuFCYLcw1Lg==
X-Google-Smtp-Source: AA6agR6v9SEpaR8/h54E7r+sUehl1VRLwX60543GLlfUliZxUS0Q7Y+G3LNY7pi73BRd34qYx8zL8bEUVnnr9mRK28U=
X-Received: by 2002:a67:d901:0:b0:390:d093:591a with SMTP id
 t1-20020a67d901000000b00390d093591amr12463484vsj.81.1662297678763; Sun, 04
 Sep 2022 06:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAB7eexLHN1gn2QPdo1_PF70sPbo2cA8skwG17oZb7+J1DQ+J1Q@mail.gmail.com>
 <CAB7eexKGRgDWBLiRs=U70OPLREESi+bCgwt=7wWCESBDZDM=zQ@mail.gmail.com> <YxC7ix+MerW5xGsB@kroah.com>
In-Reply-To: <YxC7ix+MerW5xGsB@kroah.com>
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Sun, 4 Sep 2022 21:21:07 +0800
Message-ID: <CAB7eexK+x8+RZp16aJFmdmqqEL=NMYp+Fy+hAJG+CWUUEH1_fg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in configfs_composite_bind
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply! I ran the reproducer again on the master
branch(commit id: 7726d4c3e60bfe206738894267414a5f10510f1a) and it
didn't crash.

The reason for not using the latest version is I can't attach more
than one gadget at a time using `configfs` and `dummy_hcd`. When I
attach the second gadget with a different `udc` it always fails and
the kernel message says:

```
[ 1625.254858] Error: Driver 'configfs-gadget' is already registered,
aborting...
[ 1625.271018] UDC core: g1: driver registration failed: -16
```

I'm not sure if this is a new feature from version v5.19(v5.18, commit
id: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f works very well) or a
potential bug, or my mistake...

The kernel config is: https://pastebin.com/raw/SLmNMMRd
The shell to attach gadgets is: https://pastebin.com/raw/2eDPNip3
The kernel log is: https://pastebin.com/raw/MaDwMQWk

Best wishes!
Rondreis
