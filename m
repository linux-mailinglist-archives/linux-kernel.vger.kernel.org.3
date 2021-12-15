Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83B9475E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245173AbhLORNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:13:37 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55191 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232113AbhLORNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:13:36 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2849632001BB;
        Wed, 15 Dec 2021 12:13:35 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Wed, 15 Dec 2021 12:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=ZhFghGUQdLCtzrxa61716yC9XoQx
        oRMfU4SiLNMG7MQ=; b=RhFyKoEUFW8LIcxvPJeK+9aahaf/OZwWqFa5DM5Ix0Q6
        81HIowTmughou1JhEAAXTp2SztojPUCOTf7Xme8Y2A5e1h5fhIbPlfs8xSYlE2Xb
        Oed84XjTBPciijIYWMsGn78s1nXoCDfLe+7/IeYt2p/9z0G/uI35jAuTKF6lyHQk
        1gXEprhQhPjVZEmCrlgWa7qquvYEl0+qdUcfLmeNPAoRWLZJ+iesUSIAB2jh9jRl
        sFnLHeFN3ZMuap7+nFKUeB4RWK8RfQaF5kttF4Hq5HGFseOYAI2Lm4mB68seR/24
        WAKP1EuqwRP3MHsYtel20GtixKrHOo3YI0isN1yluA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZhFghG
        UQdLCtzrxa61716yC9XoQxoRMfU4SiLNMG7MQ=; b=Pdb0pX17w4lECWP7FnJOu3
        giZ7Fln9ePm/ytfAx8lV4Ax0jBLeDqc5s7tFWYlm0PnICEEWDyPX+WsWKeWeFw45
        q6K3jNWqPgKuCHtytJPyVA1DtF4MzRZwPcbVrkpP4IwHDjWHF+lstf86hR4oZMw0
        jAleuWdnGrD8iErQ93kgFYoP2b7UAcY5RHS6G03ENZtsahzds6r6zKeWwzHw0Vkw
        rToYu6MGySCWvISmnV3NbICf81NPTftAP6u2/IFbhTLrxrCWlZP28Ibt35GRKGsD
        AgVFPhvLyAAsbtSSbSAosQTsxsQm3jzYPi1K2RCvaco3Vf1imfYGC6d/zB6eZlag
        ==
X-ME-Sender: <xms:PiK6YRpuUH9H4V7W8PjuhUVDAQ6fD0tCrSYuEWBSSq4gUaJ0rvYGhA>
    <xme:PiK6YTpZGMy3DPB-MY5kO1eSZSsMS12MH0GQVgYjOHV8BTSQK6rBM4iW2-J7PsK0n
    Vf68UdcefAdbqpDFLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledvgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:PiK6YeNxYEthc9iFViV6aOVIsNofu-Q0HgpyZ5s1qYC2YLiq_X_EFw>
    <xmx:PiK6Yc7bidppZDoAAQpRE6FUAGvMOUvAkjCAWVNjRYX4_q6g3JA6-Q>
    <xmx:PiK6YQ5vWWqZz0UAz60WVcXrrHnkO3ozH1-2UPtVapyMMmQfu6bDeA>
    <xmx:PiK6YaTjofVkH_D7DuWCF_RkIc1VsvHTIDL82EzC3-FSQfPKAvdGhg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 151282740372; Wed, 15 Dec 2021 12:13:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <d4ceb942-566c-43a5-8850-4f98c9f82d9c@www.fastmail.com>
In-Reply-To: <20211209055049.99205-2-marcan@marcan.st>
References: <20211209055049.99205-1-marcan@marcan.st>
 <20211209055049.99205-2-marcan@marcan.st>
Date:   Wed, 15 Dec 2021 18:13:03 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: apple,mailbox: Add generic and t6000
 compatibles
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Dec 9, 2021, at 06:50, Hector Martin wrote:
> Much as we've done with other blocks, let's introduce generic
> compatibles so drivers can bind to those and still work with future
> SoCs, as long as the hardware remains the same. Also go ahead and add
> compatibles for the new t600x SoCs (we group those as t6000).
>
> Note that no DTs instantiate devices with this binding yet.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
Reviewed-by: Sven Peter <sven@svenpeter.dev>
