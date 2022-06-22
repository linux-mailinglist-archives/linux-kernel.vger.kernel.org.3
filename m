Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C368E554DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358479AbiFVOm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358470AbiFVOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:42:55 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E7321
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:42:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 537115C01F7;
        Wed, 22 Jun 2022 10:42:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 Jun 2022 10:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1655908971; x=
        1655995371; bh=q+1sB2EjKcE1D8Tt+wDoAsTfPMB0jI+HIrgtAgz1Z1g=; b=H
        MBpm6cETzus8LyhNcsTi/26c4/P5tTar1NhG1plx5rhcRcHZdgAc95ffPMiYhPQw
        yJR18tuvxG9ql9ChnqdhwRrhuS1m6rGY90VDhi9f0kewSCrMkzNqnmRDy91b7F5Y
        JkF2ToAt9eaXn2UK7gj2GrMGyyL/5wG1OoFO4NW5BRXwm80/Ubt1AOEId91vHzRB
        1DRy45B30mvlkb0YlGUE5ED/2s3K14gCKCWQeF6FELtFUeizUsqu+GNu8EuZCueW
        5LfrZ/LGxk4Ay2uXkG1r44AeuXsYnVsasp87YIEPrAWIE2mQf/McqXOX16mM3boo
        qrrL0YF819jBy4oVulYZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655908971; x=
        1655995371; bh=q+1sB2EjKcE1D8Tt+wDoAsTfPMB0jI+HIrgtAgz1Z1g=; b=R
        wqfRR6Juaz2hc5Rcz8iZI6RH5X3CsL/5o7xPSBgLKuOl7uFV9VmnN1D7ag7t7rws
        mmixvzfzBKlHN/0fID/9SGwUsUPYQ5jpZrl690ASphhwMPrEQ2WN7lA0bkeIPTrh
        g9MRBRm4sGBi5+QaOLMZd4XQ8dTpszTa3lmw0KAIqnZaS1Raftqt5meyTAqa6CiP
        h9gwBhUfLnoORe2q8g4PzDucW7ICrebCisO6xXOAIV+FRa7bGKNfDh751knhi1Ln
        jRfF9wlhJdvGq83nqXK6vKCDp7VZKZ6ONz80kpZ3w6heZYsEEsQYKzjvUaVbrMcB
        KzxH1xArxTH3knAQoxGAw==
X-ME-Sender: <xms:aiqzYj7Nl09fEdW-Z0VdCHW0Iay_tTxkJksHSnbBCBLuKPd6-QjXBA>
    <xme:aiqzYo4zJoexBUS7cO0BE8QMv2G3Q3ifYuF_IM3BTiGYv_xYqlTII99C7KIigGrXA
    O1NZfAS0WhZqKngeVk>
X-ME-Received: <xmr:aiqzYqff3X82sK0khptgMKK1ed2SHGB-2no1Pxn-3PibmM5tMLAD2ujknviHQx9DtJl6YMayghn9DDB8mZSzK_6akoKWmAT9B6VlUdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefhedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvges
    tggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeeuieeggffhffffieefheduie
    euvdetgeeufeffvefgtedvffehheekffevudefieenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:aiqzYkKwPw3gIfJ_SjIbs_w9UUBhK1M1Ui1r83ckpM67FWVVOyEASA>
    <xmx:aiqzYnIcldF7v-xnUXWzZoqs4tpeYgPHayL0m2NqHG0Dk7huZ_Z4VQ>
    <xmx:aiqzYtwkCspe4ZLfKbz4BRnmjSmJLqvYXvQeIfXCbJsjN2K7TmgNRg>
    <xmx:ayqzYkq92ysytwgfHg_TQnIczgbONjc9jHybzhf5Bely2wJnD3l5Zw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jun 2022 10:42:50 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     farooqui_saud@hotmail.com
Cc:     Maxime Ripard <maxime@cerno.tech>, wens@csie.org, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jernej.skrabec@gmail.com, linux-sunxi@lists.linux.dev,
        samuel@sholland.org
Subject: Re: (subset) [PATCH v2] drm/sun4i: Return if frontend is not present
Date:   Wed, 22 Jun 2022 16:42:44 +0200
Message-Id: <165590895784.604863.5392246455510678871.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <PA4P189MB1421E93EF5F8E8E00E71B7878BB29@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
References: <20220622075725.y6ws22ielpc4pmxw@houat> <PA4P189MB1421E93EF5F8E8E00E71B7878BB29@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 13:59:17 +0500, Saud Farooqui wrote:
> Added return statement in sun4i_layer_format_mod_supported()
> in case frontend is not present.
> 
> 

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
