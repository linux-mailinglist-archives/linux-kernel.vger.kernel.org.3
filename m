Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98074B4305
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbiBNHgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:36:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiBNHge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:36:34 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A8A5A0AF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:36:25 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l14so14712838qtp.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=DJb3H9k1RoLuRCYBQIyf/S7xP16DHTTl/b/4dHlbEFk=;
        b=SHviuUWkRdIirgu4jo+5R0jZrs2MKvJRxa0Oor/KyXjgCzhULvbTK6njE1g045X4x7
         TWSC9Rc7Sp89V12bqLKiLbPGYFvuIBd2xqtzX7ZtohNIZeeDDpuwgMMkkstf6I2RZ2SR
         1rpJVsB/yR0EayMPyEAf6YlVO2tFkRfykNEVWAcnT7W1tCYDCJOy2cg9vHOf+ZCRzqo5
         PlxO++n+Dp+C22/BbWEQgKK8LJxIumborKrwEMeHxoKgp6ATWh7w7Wz5z23Ctt6UDkNa
         nFlskOQKnOKWco0jMTKE0AA0CH1CcxrdxLs2Y8GWNSWI0z/peOx7dmYTQv6+OmVaeutF
         +dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=DJb3H9k1RoLuRCYBQIyf/S7xP16DHTTl/b/4dHlbEFk=;
        b=TdUioDOFDmRRLfZkaZFipreVZ8rh10q9ixnGiXsLTzAhNahrLZD2wZB1pZAfLCbTwd
         S8Ra9nxzIh6GhUoxV9E1TBBLjT7/BJDLsHbVAH/MZb3YlvqRFdlQSANFVQCBGYbxwJih
         D7ewalkrtBYWDgQLXaTkmLc3niXJkP5fltVyG66K/IFPq9/cZzl+qcz8dkYj41LrIq+8
         Ue5YXmJP6xRHpvwctJq4VzHr4M55JwAs8Ef2Dgx7eEdiPVyvaN+5yc88iMTeGNeMhhuL
         KoBiqi2s2SxK0mpoJ7L9GMl4Q06smMAaZ2mY4S0S3jH/g+NdGwvN7fjhcbhQ8oS2aLoN
         ZZNw==
X-Gm-Message-State: AOAM531xqLVWrm8AjPVbPyzeyquwBrBRNjEBgIGpJLcL+LZMbg/pzBDX
        eKD29IPcQldahoElcWxUtIKh2mkAgekSJw==
X-Google-Smtp-Source: ABdhPJxbn/nu6Ezf0s3ZlITnHRXlxl/qzIW8mY+p63hmNzWbEOx1Vl27A/99ZQsdVeSoWQgt/hif6A==
X-Received: by 2002:a05:622a:354:: with SMTP id r20mr8506388qtw.0.1644824184029;
        Sun, 13 Feb 2022 23:36:24 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 22sm17988632qtw.75.2022.02.13.23.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 23:36:23 -0800 (PST)
Date:   Sun, 13 Feb 2022 23:36:01 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rajat Jain <rajatja@google.com>, Wolfram Sang <wsa@kernel.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "loic.poulain@linaro.org" <loic.poulain@linaro.org>,
        Andrew Duggan <aduggan@synaptics.com>,
        vincent.huang@tw.synaptics.com, cheiny@synaptics.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: 5.17-rc regression: rmi4 clients cannot deal with asynchronous
 suspend? (was: X1 Carbon touchpad not resumed)
In-Reply-To: <Ygm+5rS7Cxeea5Dp@google.com>
Message-ID: <3741afae-305a-4ba-187d-eb52b039bc1a@google.com>
References: <89456fcd-a113-4c82-4b10-a9bcaefac68f@google.com> <YgF/0QGFN4SppLKg@shikoro> <CACK8Z6Etj-gq1VKpkUBstiXEETekPWG9p9gKBtuFaZF05pQEvQ@mail.gmail.com> <CACK8Z6FUsceYgBoaAtN8o4m9HpZaBZMt0Nqtvw0a1Z3EuD_nWg@mail.gmail.com> <YgHTYrODoo2ou49J@google.com>
 <b76771e5-b8e-54c9-2474-d5a73d236cba@google.com> <6f1103af-595c-ed0a-b946-97a9331ed148@linux.intel.com> <Ygm+5rS7Cxeea5Dp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2022, Dmitry Torokhov wrote:
> 
> Sorry for the delay, but I wonder if you could try the patch below and
> tell me if that also fixes the issue for you?

It fixes it for me, thanks Dmitry; with nothing unpleasant in dmesg.

Hugh
