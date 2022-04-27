Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605DA511A77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbiD0Ntg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiD0Nte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:49:34 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08483F56F7;
        Wed, 27 Apr 2022 06:46:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i20so1608544ion.0;
        Wed, 27 Apr 2022 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prEocCfY7/rW3PwyVmCg0lthn9pqud0hftWHvrexhQo=;
        b=Icd8BrDBG73K3v3KeV90v27I3S//fAYcIxoebG81LxDXGGDv8rB9GmNkRij5vTWmdN
         euAaWkfmcfF79GcJKp6KFHPH9RzkAeKM/74/DCeCZlarAPPkbzk7gNwoCJzx/tiUK/RK
         e7nkz6j1WxehpZ/bAQkxuMSsO9FDLbk/LMVtZ/gtjeoGfqGp5EvcACkVSNkyb/qzXOao
         Dxq8+DyDtXeDBb5hBbGzkZMbGwCoaB1E/cJAHNHlMTI9xingc9wEdOm5PBeIFMFgdLXA
         dq4u0oQc/iEQvPQ3QLg5A7pmpk1DcsIgz2DHngsr6MrA0nhNrvZuhzNa88HS0PZed4Fw
         FI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prEocCfY7/rW3PwyVmCg0lthn9pqud0hftWHvrexhQo=;
        b=xvfiIDCAWkzJ1pvg0TZNLTxtjEWjRZZf6sUAaM4OMgQ7aQoqUpE3PZb1gHw4mGny6h
         aja4V28zqxEqgDxVdzL/yBPjtP8MkqM9qODQCUOu54wXDCZkcCN2sGav0w1ypF14uiT4
         ymmvOVWqHwmpQRDPyFcrbU3VmnvPDn2JvCpgfIB7x2Tn5G9Q4yyI6Q4MuFkrtwsS/pzN
         Z1b33xsy+zmG18k59ZBi+DW7HVdhDM0xPiBzZ0j85wzOmULla+xH9MaWyjQGO+uPrFov
         NlACg7nIrQnwiKkMzVi58DJmOiceLLpJb6YP3hZalChicMC+hQigXxL1KNOs4ofqxYgj
         VDRg==
X-Gm-Message-State: AOAM533Q3NFzZuT/eR1jYI0Mro6WIgZabI1dRkgTTrGm6NzFTLB/cNoo
        6AmCd8jQHAcC+KYHebdJ62NfRQK01xYA9HLukGE=
X-Google-Smtp-Source: ABdhPJw1oGQuks3mvOOazLRAbtJVRr5lKyc18XoVK4M5hQMRi3ri7JAx5kNmy6WOgrfyMio1s19YLFN+9Ew7hs7/Za8=
X-Received: by 2002:a05:6602:210c:b0:654:6490:d2b0 with SMTP id
 x12-20020a056602210c00b006546490d2b0mr12004333iox.106.1651067183168; Wed, 27
 Apr 2022 06:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220426092340.495704-1-eugene.shalygin@gmail.com>
 <20220426092340.495704-2-eugene.shalygin@gmail.com> <20220426151656.GA3119637@roeck-us.net>
 <CAB95QASxuS=RDN6MRJ89O0pSpqQSaWFQVeyedGyda01FGtR7GQ@mail.gmail.com>
 <6d69fb63-a84f-31e5-0a88-4a154e290573@roeck-us.net> <CAB95QARDq1Tr64dvPVemXHRNyu=T5P7LJ_DUn7sdHauUB6daaw@mail.gmail.com>
 <8a8579df-1fd6-32bb-3e27-297efefe28c4@roeck-us.net> <CAB95QAQPRVO=Cd27QthFZ_fDTr=Nvzqzrh0QnFs5475yTx+qJw@mail.gmail.com>
 <f155e829-3418-379d-760e-77cf70cb34e9@roeck-us.net>
In-Reply-To: <f155e829-3418-379d-760e-77cf70cb34e9@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 27 Apr 2022 15:46:11 +0200
Message-ID: <CAB95QASkOP9Fc5cuimWTgRk1VbW5qtPFZ4xrGGqMG5rq6M-Sew@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, thanks!

Eugene

> You are correct, that is easier. I thought that it calls the probe
> function directly and bypasses the normal probe handling, but that
> is not the case. Sorry for the noise.
>
> Guenter
