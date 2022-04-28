Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6B512B14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbiD1FuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiD1FuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:50:00 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F682AC5E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:46:47 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id f38so7159493ybi.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acCmiAFeUKSb3f8UtEoB0zywf8yA7MpHB3Qa5wbIUz8=;
        b=mnuuKuGElQavxBj7lser61CbewlQVKMabIOG3mpBZHBFpIp6VhAnILfSQbs1NIAiOo
         HUdQLw0Dg+jZw9qp72ww+HThNqqglc3yw6Q/YBr/wJ9vSgA/MTxe63kaP5x7BkAuxov/
         33BFaNrufrwrtlttgVMpnwzOoJAX6EhdOYIQoZtbcFtntEPNt8qMi4OKBeR9515FRtnS
         e8G9Uro+3ItpJtO5UVxCRFi8xN8iIOHLOlVxUQQ8ac1KL7LtZZzA0DzStHv9KlLa5+r+
         BzozPUZX6x/YRkCoG9XbM7eAGLS7y+CL+r4nwQfxiUkaZHMgaylouPSkXQT+Yhuj5XBU
         FSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acCmiAFeUKSb3f8UtEoB0zywf8yA7MpHB3Qa5wbIUz8=;
        b=5/PwZ+PIR/ZeGZUnYKsHhkMkt3Q/h1YW9qNtKmclBkN3dQtXKG3zk11qa3A3HKHxsP
         /TKAFFKIxe+/ZuuI49kj9Oe87jbg8hykMn46cYkpOL+PBFV+y/diJmIvm2Vor65YxXwi
         ydw046Bxksa7vr8RpLWq3N0t52aVgeYLlG2IZH9yEcpmb/9n8YbdFH6MDtGeczRaKnP8
         GTGBF35Wcpo6gWGw4Vxf667VMVO1XuVQrfVCYvEgBd1FxyxNeVwyEC4RIrYVpuZ9SHp1
         +5Ans25p7nVMz8RSRF3UsNkxTw7AzrFeZQ5xRhiTZY7QqOv4ZCAX5I2S5ipCF+TbWoU6
         Pu5w==
X-Gm-Message-State: AOAM530mkOl7ZkSILjdL3HsKWo7KkPhvd5ddifs2yQyxTDxheKkVE35X
        cSBZDA6/IvWl6AgnvSCP4UoOHCIUu1IM838BejWZWA==
X-Google-Smtp-Source: ABdhPJwyJpRLrfcLW7+hjh/Wrn7475LqPrZ0d6/AHSn1ri3HAWeWqm5KfdQzi7bz2ndEZbLxU4A5EQkir2dn5nofCJ0=
X-Received: by 2002:a5b:a4c:0:b0:628:b143:5bd with SMTP id z12-20020a5b0a4c000000b00628b14305bdmr30117306ybq.212.1651124806342;
 Wed, 27 Apr 2022 22:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220422013215.2301793-1-tweek@google.com> <20220427135823.GD71@qian>
 <YmlQy7jnIY6Wh7/2@kroah.com>
In-Reply-To: <YmlQy7jnIY6Wh7/2@kroah.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Thu, 28 Apr 2022 15:46:29 +1000
Message-ID: <CA+zpnLd7EJzutxcfFEoCjnG0_JhCFeyxYDtiEzaYL19rwtjBwA@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: use kernel credentials when reading firmware
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ugh, yeah, a put_cred() is not called after this.

Good catch, I wasn't aware that an extra call to put_cred was required here.

I'll send a new version for the patch. I'll update the commit log as
well, with the recommendation from Luis. Thanks.
