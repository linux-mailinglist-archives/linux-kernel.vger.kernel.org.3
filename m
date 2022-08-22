Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1162659BC37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiHVJDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiHVJDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:03:16 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECBC18D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:03:13 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3246910dac3so273997147b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EuziAoq5ZbtPrSZbeUk8bQqTzuyS7XPxbOwKK2h6M3I=;
        b=Sw3kIy20SNGugBW8dL2ZMcQGAgqJ/0rc8tznUC4Q0+BOOO85ccRBiVpJitf6eK1Iaa
         RjQCiALJNCBQ6CFRTYn5FHPW8bV5kgVDvlP6Yq32hZslXgIJmJr+Jna1zxeXneR38Ihj
         34zAejNuIsR38piTK9NXJDONa4Y76Jh9fsQBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EuziAoq5ZbtPrSZbeUk8bQqTzuyS7XPxbOwKK2h6M3I=;
        b=fkRQLvGbZRIqAMw/YewGTJSt9tNoy5veJjj3nMReYFGYTPUiJr670cRg3ZAnD16Ds7
         K0GFGiEn5a6MUvESkVs6iwozs0kP16FMtuHgsMjGvIsHPIs6Kb1qlnAcAS+f8tuJ0YuL
         loTfudsIXX9g6f6wI2iZhidnnVWLwMu7f0fpaa2nnwV0T/FfAT2o9uPUTwfwnaZ7+dfp
         t6c/5q26UMkJSmz+BFyedsCMvaUA8+0YZDuFBUWqrhVjP7/5zpUyy2NK867lr1jXKdQ8
         QNPxXWbI1QJIegOXSnke0owL+lbhIv8wZ6ML4b+Yup3EPmeHBS107m9citD03D2b3Zuc
         U3kg==
X-Gm-Message-State: ACgBeo2AlHPa3JnwCB/AC807kwmjHW+ubEduZcAQPIU6KzO8T5wwsg6m
        8EaBUeaT2WCzeG79VHAoAyjOvA6i1rU7FqdL+2o/8Q==
X-Google-Smtp-Source: AA6agR6APdt78F3uw+1hsI55dL+JHbLtSlHcfqi0jLhAPn0QEEgxu7vETGl/x/2GaGSTbsdSnHe62HeLvEmG/XpC7hM=
X-Received: by 2002:a05:6902:100b:b0:695:bd4e:95d6 with SMTP id
 w11-20020a056902100b00b00695bd4e95d6mr2569366ybt.595.1661158993033; Mon, 22
 Aug 2022 02:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220815104739.v7.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <Yvnq5o5f+qp5zs1c@kroah.com>
In-Reply-To: <Yvnq5o5f+qp5zs1c@kroah.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Mon, 22 Aug 2022 19:03:02 +1000
Message-ID: <CAONX=-fScRJt-j1USO6gKXm780S=XBGHVc_LUziSZDiStc5P6A@mail.gmail.com>
Subject: Re: [PATCH v7] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 4:42 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Please provide a lot more information about this in the changelog text.
> What would you want to see here if you had to review this change?

Hi Greg,
Sorry for toppost, let me try again.
Can you clarify what specifically is missing from the changelog?
The comment used to be on the "c" file, but now is moved to the
documentation. Is there anything specific missing? Or do you
mean commit messages?

Thanks,
Daniil
