Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106550D0EB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiDXJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbiDXJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:51:04 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1175D44A2D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:48:03 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id e4so14049568oif.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NR9IcAf4zZ7TVMjsW1KdEsz3dFd7cHl2Hh7bXybUL2U=;
        b=mpfmbVoKuOqB1v7GbqmtgQmQm9XWZqwnPNkS8gpI5GQ55pmnrH8oe+FpMHDZm23m6O
         W1TQIDMzQUgc+KXv59n8mcdwKkwr4lq2n24/ePNScbJe/FItbOCNX5PdFkGoBfBEpsv0
         Q4SFy38RsMuKKRWSG/l+dTcplTBup0SdpVjHBx+PQmfrAKA4YpWOYRXdTJjcwLvr4qKY
         4u7SlFk+9zs00GGIgfzRtgXYymJCOZoCtrcD0sAWniVHwbw/4fJueyIgd1d4j28RkfVh
         oGSDnM79apC53b20BI3Lwrn6cbYg+87WFZ0APD5yhzX63/5E9lVERgiBglCdcFAzdHI0
         FPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NR9IcAf4zZ7TVMjsW1KdEsz3dFd7cHl2Hh7bXybUL2U=;
        b=EAEE0avgvyFOB8MbDqhTfLeBabxiM7lTTEoz2sLzyAA/rTAPWsuJ3rWA0V4eKYx+jc
         N5a58AmQUFRgq0DYHg4cNV0tKGTGzPRVu7GrqdMGWM2/KZfI1UjLe/YR1QiIHeoOC7F9
         eHJNmYBFUiWKJbSB7aHLUuo9zy2S4dIa9uHe03QeMtUwoviR51mPXkuLWlH6t4IAr+8T
         5ckTYswFekEyie8onEwqi+Bb+aRDiySu5XBr8ovVvRZ4yPAuEae9N8Pw3OvaG7R6lbcd
         29FaMJznVHEIFjcATZR6VrSkTLZo3TGb4aqKIX+rW2cYUaflTFiCfmL2Rrjo6zqPNOJ5
         egNA==
X-Gm-Message-State: AOAM530fg58iHRHv/ReCRTWdwtGc9ING3rCoM8H5rB8FGPRKfcEAOp0H
        WM/bEHzuY8uQWqW1VZcHrwhxFKZobQ4kcFNYejs=
X-Google-Smtp-Source: ABdhPJyzpVb5ltwaTMr93ZjDy91prWkmEvZHBozs3ZJbbdW41m4CzE+CAzSLMA5Xy2TOBs8IKsNzTFerp04cMal8cTc=
X-Received: by 2002:aca:1306:0:b0:322:9104:6cf9 with SMTP id
 e6-20020aca1306000000b0032291046cf9mr5720845oii.112.1650793682840; Sun, 24
 Apr 2022 02:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220423184745.21134-1-makvihas@gmail.com> <3607997.MHq7AAxBmi@leap>
 <CAH1kMwSZbogptqDdiJVoiLcZamY_PmX_p0oXPZguoAnY=dibug@mail.gmail.com>
In-Reply-To: <CAH1kMwSZbogptqDdiJVoiLcZamY_PmX_p0oXPZguoAnY=dibug@mail.gmail.com>
From:   Vihas Makwana <makvihas@gmail.com>
Date:   Sun, 24 Apr 2022 15:17:52 +0530
Message-ID: <CAH1kMwTDaOgDFADR8OMWVOxg6pUmEAeprqOb_m6t3Tig-zOXgw@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: fix a potential NULL pointer dereference
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
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

Please ignore this patch, Greg.
