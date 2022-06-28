Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB87655E194
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbiF1JXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344222AbiF1JWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:22:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE321D312
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B16BAB81D35
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC9BC341C8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656408152;
        bh=3fbAja5rgkL66KWqFwLeSPX7PtzuMg9ParfKCMJhJIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g1r5mkW2vYRcZzhzH2VK3cluxMtV3yqSPy+KCwH012YWscYHhjH2txvBh6HJzL+lj
         CyKAebiRMqxhsVdRkojRHbDgdXfd2VHrLKPRgI5QnpdiMDR4JU2bx0zZN5Bic8DrsL
         ZYG18GY7AYvCDvGCuWoeVHhGTDG1lSJFySyaXYv3ASoobRdmq+WQO61SewXhDr5QKi
         fO9cU+MxfYrh6I/f3B40xlFIvxRlsLmX2mPt32BJrfXL+cnYL8UhZoFQoRqYRVe7dd
         zZVCQT7eiXhaKq8IePOJTpfhGHO8iZ4NDYmDUwMUJW9IOp4K1t9wYvwMcgtON0Sc2W
         +gOQ30xWW05Jg==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3176d94c236so110556287b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:22:32 -0700 (PDT)
X-Gm-Message-State: AJIora+IAyc1/OnuSXz/espcH3ffr5tqqQyERUiI0GVsVcJFHN36OYSs
        sZIq70neFWZVaWeOppkg7g984o8ImIyrVdmxFPI=
X-Google-Smtp-Source: AGRyM1sZrqmcbcXuTCWvdobNXGoySg+7item504Pp4yhySAckI/c+nCDgC+RLzYpHsxXndVcVAg1Fb5Oial7Fgowi+A=
X-Received: by 2002:a81:9286:0:b0:317:d78b:fa41 with SMTP id
 j128-20020a819286000000b00317d78bfa41mr19620872ywg.46.1656408151422; Tue, 28
 Jun 2022 02:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220627202620.961350-1-ogabbay@kernel.org> <20220627202620.961350-12-ogabbay@kernel.org>
 <YrqhaBuzY/GkQXHx@kroah.com> <CAFCwf13eVS4iETpdgRp72KoNw-X5h1Japf=pNQ-8MdQcJ4h8WQ@mail.gmail.com>
 <YrrF4/kSbs+25BUR@kroah.com>
In-Reply-To: <YrrF4/kSbs+25BUR@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 28 Jun 2022 12:22:05 +0300
X-Gmail-Original-Message-ID: <CAFCwf13RNEyZh-FkXo5h7YXx62wrZEoEd344ihjv5VO3ZpnQkQ@mail.gmail.com>
Message-ID: <CAFCwf13RNEyZh-FkXo5h7YXx62wrZEoEd344ihjv5VO3ZpnQkQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] habanalabs/gaudi2: add tpm attestation info uapi
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Dani Liberman <dliberman@habana.ai>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 28, 2022 at 11:51:48AM +0300, Oded Gabbay wrote:
> > On Tue, Jun 28, 2022 at 9:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jun 27, 2022 at 11:26:19PM +0300, Oded Gabbay wrote:
> > > > From: Dani Liberman <dliberman@habana.ai>
> > > >
> > > > User will provide a nonce via the ioctl, and will retrieve
> > > > attestation data of the boot from the tpm, generated using given
> > > > nonce.
> > >
> > > Why not use the normal TPM api instead of a new/custom one?  Or is this
> > > not a "normal" TPM device?  If not, you should say what it really is.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Honestly, I'm not that knowledgeable about it. It is hidden behind our
> > firmware code. We just provide a communication method between the
> > userspace and the firmware, as the userspace can't interact directly
> > with the f/w. i.e. The driver is a transparent tunnel, it doesn't
> > interact with registers of the TPM device itself. The "real" driver is
> > in our firmware.
> >
> > So basically we just got definitions from the f/w how to fetch the
> > data from them and how to expose it to the user and that's it.
> >
> > What to do in this case ? Is this considered a "real" TPM ? I imagine
> > I won't be able to connect to a standard tpm driver in the kernel as
> > the h/w is not exposed to me.
>
> How is this hardware designed?  Is the TPM in here supposed to be a
> real TPM for userspace to use?  Or is this just a random hardware thing
> that you use to validate your device somehow and is not supposed to be a
> normal TPM as per the specification?
We will go talk to our h/w people to find out and I'll get back to you
about that.
In the meantime, I will remove this patch from the series so it won't
hold up the entire
support.

Thanks,
Oded
>
> thanks,
>
> greg k-h
