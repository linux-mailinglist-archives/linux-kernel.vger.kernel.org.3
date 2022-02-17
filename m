Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDECC4BA462
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbiBQPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:30:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiBQPaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:30:07 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0568E2B1ABA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:29:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id A1B112B00557;
        Thu, 17 Feb 2022 10:29:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 17 Feb 2022 10:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=vPxH7aW8wFaF6FXxK1Tw28k9hOtTqlkQkEM3+5
        o6jE0=; b=SKicWjolSaPozz4NfRffQADKTRa8SEffMe5aQcKtd5lFyBpLDt9rpx
        lRP2rE4ApYRhmgKVpBfH7BUfvPtPeaJqlUxO7tea12zpdpDY04X0Rk4Wzvm/0ZoS
        bM9ZPdq+YzX2qwCpaqoxi8rUS8mWLsHS3RlcExLv5/3ezauOwd/jsbJecAE12du8
        t0TwYYglg+xQPo2d4HFvarzzsJZS79QlNHYHbKk7DjiHpaPyDAjibY/lwvxKNOrP
        2mTuYEEbdEr9xbkt4ABKNRgumz+7xR3u2AvNV/WpV81e6RdcsqN7YcjuSf0aSA+E
        OFfXdUGkZgDjeaCidXwp22AujZB4RykA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vPxH7aW8wFaF6FXxK
        1Tw28k9hOtTqlkQkEM3+5o6jE0=; b=oJYseGpVhw6dopA1gjS4mMuicF/26jeNc
        jTj1bCOqJtkD1BhBSWRNk9gTswXHBj7WJriUFIpasbTYniqKRPPi0h5uz56Fw2eA
        zYu/fU9u5WfyghNUJA7eYYayFsjBWEJaGwKBwGGuAXcFfyHhcKjvW3Qzu8pXCkaU
        Hmvpkve1IT5oBvwaa84AllJ/sL+fLiiSXeCJ58FNYn913ZMxq6ozepcxzKBGUS+7
        GG2QQlI+7fOUC8SLI7L8Cw1gleON+e9EJQh3QOC72pG4QUlK6XxgSolAd6D2KQ4m
        i0hZYhkaSQqnDvquoNuNotHLEGJcZ3oIhXiWP9VqwaCgSDG3yBRqQ==
X-ME-Sender: <xms:6mkOYlse3lyINLCZgOGstWHLrrOqs40UFtvdUFY263AwJZ-zPmjnng>
    <xme:6mkOYufKskfIV7amhqoAKjXRah1-kcUfPnn3LhN1XFp2JpzkNt0wQYfdd0HySmjeF
    GuSn9bVDhMsNw>
X-ME-Received: <xmr:6mkOYoxGwH-ylT7PGvPu8_tuSXwwsL6U-WT7_ZAty5oZP_FxuDsKxAxvp2Nd557noGnntn5I9zhXcpXsg3Z-f3PIQtWQiM-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:6mkOYsM9M9puVPWvhJy0JQlkQpq5OhzTFeFQLlqLUQ-BVYTV4TRmWw>
    <xmx:6mkOYl9CVjfu6xx8VC6Nr-bu-ghoA49QksuqCsEOTZVF3TgfF8VzZg>
    <xmx:6mkOYsU41iGpazbSrPqas-haUyoVCHVL8UxnAHkDsxP3oaOLjKOfyg>
    <xmx:62kOYo0cg8oz0wLBN43MwFWvllnjYuYMP_AUuaVxt_aKFTi8CJNgWErSeqU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 10:29:46 -0500 (EST)
Date:   Thu, 17 Feb 2022 16:29:39 +0100
From:   Greg KH <greg@kroah.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, quic_rjendra@quicinc.com,
        quic_saipraka@quicinc.com
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7280: Set the default dr_mode for
 usb2 to enable EUD.
Message-ID: <Yg5p45LkdsAtFFKV@kroah.com>
References: <1644903488-20557-1-git-send-email-quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644903488-20557-1-git-send-email-quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:08:08AM +0530, Souradeep Chowdhury wrote:
> Update the dr_mode for usb2 to 'otg' from 'host' to enable role switch for Embedded USB
> Debugger(EUD) Node.

Please properly wrap your changelog at 72 columns.

thanks,

greg k-h
