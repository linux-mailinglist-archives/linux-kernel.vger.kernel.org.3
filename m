Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8568579537
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiGSI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGSI2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246369596
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA6D7B8197F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C774C341CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658219301;
        bh=V6p0JslKZdae7FjHqp6PC5KHWJqbP3b6fmoqGpgqhLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kp5nettMQCfTe3ZdenIAIFmO9I6Tz+t0ydnhM7neOQYpm+m1aPbzNnrIkwXBobYWv
         tIIb8IBbDqQpV3xU+cpX+MS3OXWIvpiXtrA6uU4kVYgbgwOQHe4Jagkxe6FSmAaH1H
         GrKHZBYtyeW3qQMUN3y8e5GJZQOOhM1vfZZbieSj/X3o8IutMihPK5rY+UjdbSijzd
         62UGzLtYaissp/rCuVYsuQKagRH5OfpV25oZwGc8Ea324ucc5w451MGFpxPGYPgy5w
         DdbFHXC8kmd0e1fonpxQ9grJYlqk2aNBxz5D13MuekzBEU4bgj02uXhdncv7sidhRP
         MN1Jl8/4v+qnQ==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31e47ac84daso32655827b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:28:21 -0700 (PDT)
X-Gm-Message-State: AJIora8PbPSMcYN8YXG0pjyZA1RED+A5I3Ue4fyjdg4593B4O5N1ejcp
        no9oz2LB4pa9pAjNdfGdLUziqyS9xnKQX1/KE2g=
X-Google-Smtp-Source: AGRyM1vUTESaDkZh2SOmRziOpMeK4HSloVDizypD1VH6RySPM362y6zSKlLlLqV1gcx8xYfSr9wbImw2Ba0xuGn3Ag8=
X-Received: by 2002:a81:1608:0:b0:31c:925f:c52c with SMTP id
 8-20020a811608000000b0031c925fc52cmr34625695yww.93.1658219300321; Tue, 19 Jul
 2022 01:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220627202620.961350-1-ogabbay@kernel.org> <20220627202620.961350-12-ogabbay@kernel.org>
 <YrqhaBuzY/GkQXHx@kroah.com> <CAFCwf13eVS4iETpdgRp72KoNw-X5h1Japf=pNQ-8MdQcJ4h8WQ@mail.gmail.com>
 <YrrF4/kSbs+25BUR@kroah.com> <CAFCwf13RNEyZh-FkXo5h7YXx62wrZEoEd344ihjv5VO3ZpnQkQ@mail.gmail.com>
In-Reply-To: <CAFCwf13RNEyZh-FkXo5h7YXx62wrZEoEd344ihjv5VO3ZpnQkQ@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 19 Jul 2022 11:27:53 +0300
X-Gmail-Original-Message-ID: <CAFCwf1330ZqRXd2emxnk4LdTv6i4RYu6sKV10PdFMLntv_W=Fg@mail.gmail.com>
Message-ID: <CAFCwf1330ZqRXd2emxnk4LdTv6i4RYu6sKV10PdFMLntv_W=Fg@mail.gmail.com>
Subject: Re: [PATCH 11/12] habanalabs/gaudi2: add tpm attestation info uapi
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Dani Liberman <dliberman@habana.ai>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:22 PM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> On Tue, Jun 28, 2022 at 12:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 28, 2022 at 11:51:48AM +0300, Oded Gabbay wrote:
> > > On Tue, Jun 28, 2022 at 9:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Jun 27, 2022 at 11:26:19PM +0300, Oded Gabbay wrote:
> > > > > From: Dani Liberman <dliberman@habana.ai>
> > > > >
> > > > > User will provide a nonce via the ioctl, and will retrieve
> > > > > attestation data of the boot from the tpm, generated using given
> > > > > nonce.
> > > >
> > > > Why not use the normal TPM api instead of a new/custom one?  Or is this
> > > > not a "normal" TPM device?  If not, you should say what it really is.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > Honestly, I'm not that knowledgeable about it. It is hidden behind our
> > > firmware code. We just provide a communication method between the
> > > userspace and the firmware, as the userspace can't interact directly
> > > with the f/w. i.e. The driver is a transparent tunnel, it doesn't
> > > interact with registers of the TPM device itself. The "real" driver is
> > > in our firmware.
> > >
> > > So basically we just got definitions from the f/w how to fetch the
> > > data from them and how to expose it to the user and that's it.
> > >
> > > What to do in this case ? Is this considered a "real" TPM ? I imagine
> > > I won't be able to connect to a standard tpm driver in the kernel as
> > > the h/w is not exposed to me.
> >
> > How is this hardware designed?  Is the TPM in here supposed to be a
> > real TPM for userspace to use?  Or is this just a random hardware thing
> > that you use to validate your device somehow and is not supposed to be a
> > normal TPM as per the specification?
> We will go talk to our h/w people to find out and I'll get back to you
> about that.
> In the meantime, I will remove this patch from the series so it won't
> hold up the entire
> support.
>
Hi Greg,

I have talked with our H/W people and Security architect. What we have is
an embedded TPM on-board, pre-provisioned with IAK, IDevID and their matching
certificates.

We use the TPM chip to provide a signed measurement report and signed
attestation report to the host. i.e. we just use it to validate our device. It
doesn't behave as a normal TPM per the specifications.

Therefore, we don't expose it as a host TPM because we don't want the user to
be able to interact with it. Instead, our driver exposes only the TPM
measurement report and attestation report and the only component
that directly communicates with the TPM is Gaudi2 Firmware.

If we were to expose the TPM directly to the host (as the TPM driver in the
kernel requires), it would defeat the purpose as the host will be able to
manipulate the reports of the TPM (reset and set values to the PCRs, etc.).

I hope this clarifies the real situation. I suggest I will rename the code
in the driver that exposes this to the userspace so there won't be any
confusion. i.e. no one will think we are exposing a TPM device to the host.

wdyt ?

Thanks,
Oded


> Thanks,
> Oded
> >
> > thanks,
> >
> > greg k-h
