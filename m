Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E375F579895
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiGSLfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbiGSLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC1A112F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE52F615BE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ADEC341C6;
        Tue, 19 Jul 2022 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658230512;
        bh=dbblLM+3yXa/RRyeIx14ajNevd3RW8qDPYNCdfvZk3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2fhS4JZXsJ9RmX0SVWzERjurg5DwjM/GcUUcDFjcutVif9O+prTKwsAvETaJMfl7
         7swzjY/8qZ2j4SUbYZkxK3wi4P34Y9yMLgJtR7TebFK7sCPxp9ouFWav2drmnZnC36
         JOBRtbG6jVShf3pTku4vukfhngG2LOWWdE0LKvWg=
Date:   Tue, 19 Jul 2022 13:35:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Dani Liberman <dliberman@habana.ai>
Subject: Re: [PATCH 11/12] habanalabs/gaudi2: add tpm attestation info uapi
Message-ID: <YtaW7YilEMLNfkmh@kroah.com>
References: <20220627202620.961350-1-ogabbay@kernel.org>
 <20220627202620.961350-12-ogabbay@kernel.org>
 <YrqhaBuzY/GkQXHx@kroah.com>
 <CAFCwf13eVS4iETpdgRp72KoNw-X5h1Japf=pNQ-8MdQcJ4h8WQ@mail.gmail.com>
 <YrrF4/kSbs+25BUR@kroah.com>
 <CAFCwf13RNEyZh-FkXo5h7YXx62wrZEoEd344ihjv5VO3ZpnQkQ@mail.gmail.com>
 <CAFCwf1330ZqRXd2emxnk4LdTv6i4RYu6sKV10PdFMLntv_W=Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf1330ZqRXd2emxnk4LdTv6i4RYu6sKV10PdFMLntv_W=Fg@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:27:53AM +0300, Oded Gabbay wrote:
> On Tue, Jun 28, 2022 at 12:22 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> >
> > On Tue, Jun 28, 2022 at 12:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 11:51:48AM +0300, Oded Gabbay wrote:
> > > > On Tue, Jun 28, 2022 at 9:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Jun 27, 2022 at 11:26:19PM +0300, Oded Gabbay wrote:
> > > > > > From: Dani Liberman <dliberman@habana.ai>
> > > > > >
> > > > > > User will provide a nonce via the ioctl, and will retrieve
> > > > > > attestation data of the boot from the tpm, generated using given
> > > > > > nonce.
> > > > >
> > > > > Why not use the normal TPM api instead of a new/custom one?  Or is this
> > > > > not a "normal" TPM device?  If not, you should say what it really is.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > Honestly, I'm not that knowledgeable about it. It is hidden behind our
> > > > firmware code. We just provide a communication method between the
> > > > userspace and the firmware, as the userspace can't interact directly
> > > > with the f/w. i.e. The driver is a transparent tunnel, it doesn't
> > > > interact with registers of the TPM device itself. The "real" driver is
> > > > in our firmware.
> > > >
> > > > So basically we just got definitions from the f/w how to fetch the
> > > > data from them and how to expose it to the user and that's it.
> > > >
> > > > What to do in this case ? Is this considered a "real" TPM ? I imagine
> > > > I won't be able to connect to a standard tpm driver in the kernel as
> > > > the h/w is not exposed to me.
> > >
> > > How is this hardware designed?  Is the TPM in here supposed to be a
> > > real TPM for userspace to use?  Or is this just a random hardware thing
> > > that you use to validate your device somehow and is not supposed to be a
> > > normal TPM as per the specification?
> > We will go talk to our h/w people to find out and I'll get back to you
> > about that.
> > In the meantime, I will remove this patch from the series so it won't
> > hold up the entire
> > support.
> >
> Hi Greg,
> 
> I have talked with our H/W people and Security architect. What we have is
> an embedded TPM on-board, pre-provisioned with IAK, IDevID and their matching
> certificates.
> 
> We use the TPM chip to provide a signed measurement report and signed
> attestation report to the host. i.e. we just use it to validate our device. It
> doesn't behave as a normal TPM per the specifications.
> 
> Therefore, we don't expose it as a host TPM because we don't want the user to
> be able to interact with it. Instead, our driver exposes only the TPM
> measurement report and attestation report and the only component
> that directly communicates with the TPM is Gaudi2 Firmware.
> 
> If we were to expose the TPM directly to the host (as the TPM driver in the
> kernel requires), it would defeat the purpose as the host will be able to
> manipulate the reports of the TPM (reset and set values to the PCRs, etc.).
> 
> I hope this clarifies the real situation. I suggest I will rename the code
> in the driver that exposes this to the userspace so there won't be any
> confusion. i.e. no one will think we are exposing a TPM device to the host.
> 
> wdyt ?

Yes, that makes more sense now, and yes, renaming the code to be more
obvious that this is not a "normal" TPM would be great.

thanks,

greg k-h
