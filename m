Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375405ACA49
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiIEGFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiIEGFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:05:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660341A3AE;
        Sun,  4 Sep 2022 23:05:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DFA75C00D9;
        Mon,  5 Sep 2022 02:04:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 05 Sep 2022 02:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662357899; x=1662444299; bh=9rwen180LD
        zZkPZ/tp66Cb5V6hBq8lpuh4wpolRlS8c=; b=ABO7UC5o2e3QKa8CtyH2uXGZlu
        ReZDE8KAxS31qGLIN1mjNT3QJhxJRv54KPK++zu1+2nBjsyFrEew1cOlrSVqJIyL
        669ujOAT/C08Sv8wl6PDxGLubmULkcyXDEWqBD80ZMeRBq1MeETTg17E0wkdp6Jr
        ea6fvlgKUmmqZ0UZy1gfQqNhaSQtLF43i/4vVfmQEZ4N4KbT/ANBS5SnGJeXIVoI
        1SFKW9lJ8TfDUMpjCVVxDlgBt1aFq6iHw/ic1fGsiyfkCydpuh8o1BRhpWCB1iuj
        UTcaMwO3E/eKAYcWbV62YGQB2q00Zd6SVTW18316dtZD03Fs4R+E0pUGWYfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662357899; x=1662444299; bh=9rwen180LDzZkPZ/tp66Cb5V6hBq
        8lpuh4wpolRlS8c=; b=A74SvdjwRTYL2Z4LHuR7BagTAvo5/gA49tM0888usoFF
        iHacArVvNH+ilEqByFNjNcdwfpeXwvldx9EkVvYLQ2DlF9okXOGirl+/VQzdEURP
        h2zQuu9QCsKpVIuc29uTu3zoq6q2Pm0T3GUG2oXPhqnRmmsBQQUL60QYpLEDJYd6
        YJPC8pN3FLaAcNwYC0qmM+DuNBTFIt9G/2pHPrUwbuRtv52TXTz0RFUFUceMO/6b
        1h9c82EGueRJ/ye3PAFPYsptAt0gg0reQdJfL+ouSgegk3/17QTqsDIFXlwGA+/w
        FpomSU53TMS2PbXG0jR+CtHEN+sR9mGSCYAc9h5eIg==
X-ME-Sender: <xms:ipEVYyQtiCZOqSH9_wv5HDM5rtBVLV3ITFCQrnWe7zLwIkKK_2-krQ>
    <xme:ipEVY3ysr91yR-p6HRfIAhpTuiuxcrLWzDiac7akjy0v9JH8zIz8fVA7uFHRbyL8P
    OusZiPafYuPRw>
X-ME-Received: <xmr:ipEVY_0wdLqmoe2mu9syalj5_alS6SyqqO2wZ_BJ_zXwSpvpm8dIuS3PeZUgbMnf9XuEPoJ7NSl9w0tvVOLFwXIdghK4_1eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelhedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:ipEVY-CVm5uKh1Vfyh-brQ79OLxU2OYpOo8Zx_UaSRIxIFB5vUuHvg>
    <xmx:ipEVY7jUqbAmPLBHvteT-lQM9ksDh68FJQOGdy2Pn5sgKuLLs2pCzw>
    <xmx:ipEVY6p-8_dpWoHhfVxwlPaA2t8moxwcdIGcI5qBjavnCmT88fXSZQ>
    <xmx:i5EVY2Ujq3gQuV6418EUV3c3J_zUGqHiJJuX4CFrw4q_fH7ySyCmog>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Sep 2022 02:04:58 -0400 (EDT)
Date:   Mon, 5 Sep 2022 08:04:55 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <YxWRh434D2FIE+WX@kroah.com>
References: <20220901135230.37584d32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901135230.37584d32@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:52:30PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/dwc3/gadget.c
> 
> between commit:
> 
>   040f2dbd2010 ("usb: dwc3: gadget: Avoid duplicate requests to enable Run/Stop")
> 
> from the usb.current tree and commit:
> 
>   9711c67de748 ("usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Now fixed up in my tree as well, thanks!

greg k-h
