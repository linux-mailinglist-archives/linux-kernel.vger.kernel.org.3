Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2C9516EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384762AbiEBLoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384777AbiEBLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:44:26 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B7A18F;
        Mon,  2 May 2022 04:40:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 71A323200904;
        Mon,  2 May 2022 07:40:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 02 May 2022 07:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1651491647; x=1651578047; bh=Yv4nBtThqE
        z2z8r7yYm5UAXgxmvfXJ3mKRNjJrQlx5A=; b=XWBrdq0hhSl6Gb+2FEIp0X0JU7
        FvkAFOJ2evYGEsHU1LHEVtX3OURG2CqU8jiB4eulk+5d1yuqm+WkBtQ5fPeGlLq2
        SRypMUL0ygKN7dPUoRxRhBZomxeCjWcHn/CuiBt3efFnerCLEH8XfSUG2d3/GBZU
        5HnlL6pAZZobhqYtqGgvPKdbVQgTk37Cqz7PqfmCu5PAGEU1ZqDTZ+75SE9lmYKh
        80H+SdRSo80wyUWjKJu8JSSqiFGLwzgtEJ5LBbQhgmp0nj1XzIrO0+yFoSksi+Z/
        2/0f34Da3qquD6O7zoUwHmwtnGpyendHpAwyOj3ufnnklwme9b0aX4yxNbZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651491647; x=
        1651578047; bh=Yv4nBtThqEz2z8r7yYm5UAXgxmvfXJ3mKRNjJrQlx5A=; b=T
        TTbqcKCU5f+51KRayisUnNfEA9IomMlUp7nNsJQ/2QrTkWbfdA8G0k4wWt1OS8Of
        HGnzpSL1rhUzCFfyW2jWydQyK9P1ZgA0d4tmQkXFi3YxABbZ62sRB5NHqqC5rNKN
        35Yfp7d7/Yx1pzF//POa+hDcEtr3l4rnBbsjki7mbE1a0Ais5pz7qdhPgp0lKvDg
        xsThEgovUUrMZOnIxyt5f+ga3cuaPJ/Jmz+dhvl0F8EO+IUvn80lJU5ea3wvcRuE
        xfLzatXlGXAXemasp5HSBqCEAgVzMdb3YtLeqP2O/8Ey5LLmQBlPablUniwBSeD+
        twWjRqtYxO8OZt/EPJKLQ==
X-ME-Sender: <xms:P8NvYkbAu8UTaWciQgwFE5ogRqugdy5zoTS4P8OdMw5VexuspSULwA>
    <xme:P8NvYvbdLRzhNzLEhD-Qb3kk-s23FfSGsaIuYcs_hGPMPhYQbiVEdFOqSthAt9YnW
    IKU70o_twppuQ>
X-ME-Received: <xmr:P8NvYu_dGh-Vr1-8dkmh8zhQ3cbhuqPWovbOrNZVvrtm7V7UWnow3T5uwkAvT0a0agKB8FeDMJpkfgt-DTO3QE8aCSRr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:P8NvYuqkDIG-7yy07q8pKhJ1CnoirTHW4XYAVitZznNi1ygMwLCQyw>
    <xmx:P8NvYvo3iH7ZLPjgtsXyB6cVVPe7pkw6a8rremPcPwCqpNLRxeCnNw>
    <xmx:P8NvYsQNqSlqhDHislPuTu4NrCMtsDcOlbs4DtjLw5qxF2jblCzMPw>
    <xmx:P8NvYjcgiYPfopfYQ8qQll0mr_hRoTlwM0Uiaf4yHIqbYcGUGe4VZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 May 2022 07:40:47 -0400 (EDT)
Date:   Mon, 2 May 2022 13:40:45 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <Ym/DPS99n8K8Lltu@kroah.com>
References: <20220502210728.0b36f3cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502210728.0b36f3cd@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:07:28PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (x86_64
> modules_install) failed like this:
> 
> depmod: ERROR: Cycle detected: usbcore -> onboard_usb_hub -> usbcore
> depmod: ERROR: Found 2 modules in dependency cycles!
> 
> Caused by commit
> 
>   c40b62216c1a ("usb: core: hcd: Create platform devices for onboard hubs in probe()")
> 
> I have reverted that commit for today.

argh, I thought the build issues were fixed :(

I'll go revert that series from my tree later today, thanks for the
report.

greg k-h
