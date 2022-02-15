Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B00F4B77F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbiBOQ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:57:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiBOQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:56:58 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4CD64D1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:56:47 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p22so4533012lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0C7AhvvDCQEHxLq+7h7ekt5xD4opxa7U4z1HlwOoACk=;
        b=D6H0T2gdBsy/aGCBcVLV8acIUZ4Do105KWxFFVg3eA5BTwkGOnz0oG4LFEUN5O1iYB
         L0dSwLlabwyJBPwnPZvtY08Zt6JukR/7UReQwvfWIVLvnJuQEY9jPmdq9Oxj03IEwkc1
         t4hv+BtQ2w0FfwT53BdSBG5O9WmBIIUARS+O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0C7AhvvDCQEHxLq+7h7ekt5xD4opxa7U4z1HlwOoACk=;
        b=mVHxgX5Lffo1o/mztPBbCFTOZ0Jy0+9+7vfnhg6W+uuV3DEmU/B31I2oSlyDg06VkX
         jqd7NKhXq9W6WLHCIqqtIGWbX57PXpx8AtieUApI4dCpUHD1m0A3fce8emnK/h3yNyQ9
         M13pN4/CuWbzd00J11mn7Ty7NXJcWJi8xwxtS33DWNN1sPaZYKTjUagJ37AD7clLhHI+
         HmARPf9a3oesU0/Go8Bpk9QOEbk4ARI+npMxEKBaDc3FUVrWgpM5KcHUMJ4BrdO23I7S
         VKjD3jq1qeoyoohJH7InbF2Wd7BiqRAj66QBvhCMavK2JrHQcUiVHbThoRZdN6pVQrQf
         1Czg==
X-Gm-Message-State: AOAM5339zc2XC4qWDZMQ5ocoM4Urqdg3820FL1n3UyaZj2su9uW1pPF9
        mKHtN7o+fX8sA59c6qvnxVEV+Vdi+dAOmJtjm4u7cA==
X-Google-Smtp-Source: ABdhPJwwmwWIeki/es4R5uWFp0Glq1pZFR4PzkUkcdZeMMzxk/fj2daCt2UVktUUHUbKYpZlqLep4+PxhHm1oTszSM4=
X-Received: by 2002:a05:6512:224f:: with SMTP id i15mr12537lfu.40.1644944205908;
 Tue, 15 Feb 2022 08:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20220214210708.GA2167841@xavier-xps> <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk> <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
In-Reply-To: <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
From:   Xavier Roche <xavier.roche@algolia.com>
Date:   Tue, 15 Feb 2022 17:56:35 +0100
Message-ID: <CAE9vp3LT6s+qASCyF2-dEjD4caR67NLT15ad+SXi1fPPGxS-tg@mail.gmail.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
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

On Tue, Feb 15, 2022 at 5:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> Does POSIX actually make any promises in that area?

My understanding is that we inherit from the mandatory atomicity of
all rename calls
(https://pubs.opengroup.org/onlinepubs/000095399/functions/rename.html)
> That specification requires that the action of the function be atomic.

We also inherit from the link call that is required to be atomic
(https://pubs.opengroup.org/onlinepubs/009695399/functions/link.html)
> The link() function shall atomically create a new link for the existing file and the link count of the file shall be incremented by one
