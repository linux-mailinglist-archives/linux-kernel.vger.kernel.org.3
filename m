Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D33A4E216D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiCUHgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344968AbiCUHgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:36:09 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E3EB0D36
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:34:33 -0700 (PDT)
X-Sender-Id: interserver|x-authuser|info@racezone.biz
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C4D2A4C0B31
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:34:30 +0000 (UTC)
Received: from offload2.mailbaby.net (unknown [127.0.0.6])
        (Authenticated sender: interserver)
        by relay.mailchannels.net (Postfix) with ESMTPA id 20D2B4C0EA8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:34:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1647848070; a=rsa-sha256;
        cv=none;
        b=Wrbq1/Z7ZHPR26X1ke3e8vwdupbWq9yXNKNsLakWVi9FsNV0CnQacwKxWZKPMUgotkHEbV
        0GX/B6QXgUAhurfAs6ylocSHO6XzKzvS55SRP2Zabsjij9/6cGjtegfvhXH+k+HtWiCiNX
        0vL5nJnZWJD9nBfTmUUtpxiPHrmHLPbPQP3zztGqsKQ0+srG7x4G9GrbYfBhMp1tzlNF5n
        yEUr2VJPQutfFIPlzOboawvqVCDiw+rRm1wSzDLpJ+C3uuCXWa9CuJe3ItKm9RMr2Cel1S
        vrcac6bLfSkCVRnGhsvXCNbZEZXZI3WtvOQhSlTavvMy9JKcuo8cQ6tbsF+0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1647848070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=w7TF+/SRar0KIot4oqALpT6IN6OCUPnBcjvL5gLMSYg=;
        b=KYC220YVY30ed2Q4HLHULMn6UxoLlHNkf5Lz8g4KqW4RJvBUrjcoQ6tjCG+TlH/yclBWKN
        1mRaX931aavXzs9CNy29aYgf9ILNpU0D7lBaLxVcETy2p14XvGviOQIACWmKouT8LB7oRh
        nyh/GGqEzKKMrfXwm1Bd6cjk1+nf5M6snX6YdaFeXUBTRr09eo291F2p0HaocgKbPcubAL
        SWCPcI3fzLDNejZzVHN+TUVJcksdMqEYMKzZh7zDtQAdcBNX+Sj16SsJI41NZwVvirHLQb
        RcDfIa7w/Y0k53BRF+RmbaRUrHdqLXtPgRIOwQDkGBlDtSRmo2VWdfRVfqn6jQ==
ARC-Authentication-Results: i=1;
        rspamd-74bfb75fc6-zw2lk;
        auth=pass smtp.auth=interserver smtp.mailfrom=info@racezone.biz
X-Sender-Id: interserver|x-authuser|info@racezone.biz
Received: from offload2.mailbaby.net (offload2.mailbaby.net [208.73.206.19])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.223 (trex/6.5.3);
        Mon, 21 Mar 2022 07:34:30 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: interserver|x-authuser|info@racezone.biz
X-MailChannels-Auth-Id: interserver
X-Ski-Reign: 04b02c7b78409b7f_1647848070478_4129957605
X-MC-Loop-Signature: 1647848070477:3513685876
X-MC-Ingress-Time: 1647848070477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=w7TF+/SRar0KIot4oqALpT6IN6OCUPnBcjvL5gLMSYg=;
 h=from:subject:date:message-id:to:mime-version:content-type;
 b=fMo2wd4Wi9SJcRtKFdS00N3LEEwsCS9lCaZ25AzolVgf/t9UHh0M9XtpcVrWKG4Wbc3bS5kIW
 Talib+EfsXOOskgOgLleSE1cR0TY7ZYHVn0UXoid2N7uilZ/22ri6YuMKF4VX2Md7TJV/hr4Pn+
 O3LgAviyHDGbhbV5+NptFA4=
Received: from business400.mypowerfulserver.com ([194.233.70.54] business400.mypowerfulserver.com)
 (Authenticated sender: mb20743)
 by offload2.mailbaby.net (InterServerMTA) with ESMTPSA id 17fab65f8ea000dd7d.051
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Mon, 21 Mar 2022 07:34:21 +0000
X-Zone-Loop: c3ce3e447ff7f8ece9fe61b0bfcfe7f04318ddfe2fed
X-SPF:  pass
X-Originating-IP: [194.233.70.54]
Received: from localhost ([127.0.0.1]:41480 helo=business400.mypowerfulserver.com)
        by business400.mypowerfulserver.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <info@racezone.biz>)
        id 1nWCYT-00070c-C4; Mon, 21 Mar 2022 12:34:18 +0500
Received: from [39.49.22.106] ([39.49.22.106]) by racezone.biz (Horde
 Framework) with HTTPS; Mon, 21 Mar 2022 12:34:16 +0500
Date:   Mon, 21 Mar 2022 12:34:16 +0500
Message-ID: <20220321123416.Horde.BZ_W17b8INyEjO6q96VpVp3@racezone.biz>
From:   info@racezone.biz
To:     report-abuse@wish.com
Subject: Introduce
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AuthUser: info@racezone.biz
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_CSS,URIBL_CSS_A autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [23.83.209.14 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [194.233.70.54 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_MSPIKE_H3 RBL: Good reputation (+3)
        *      [23.83.209.14 listed in wl.mailspike.net]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: www.racezone.biz]
        *  0.1 URIBL_CSS Contains an URL's NS IP listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: racezone.biz]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        * -0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
        *  0.6 SCC_BODY_URI_ONLY No description available.
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Sir/Madam,
Race Zone International is professionally designing, manufacturing,  
selling high quality Cycling Wear. We are giving value to our  
customers by providing best quality products, fast delivery and  
wholesale prices. Our company is well known for providing best quality  
Cycling Wear. We have also earned a lot of reputation by providing  
best services to our valuable customers.
Our specialization in manufacturing and export of the following items
Men(Base LayersBibs Shorts &TightsGloves & MittsHats & capsJackects &  
vestsJerseysLeg & Arm warmers)
Women(Base LayersBibs Shorts & TightsGloves & MittsHats & capsJackects  
& vestsJerseysLeg & Arm warmers)
Accessories(Riding Accessories)
Face Masks(Masks)
We are the specialized manufacturer of the items in the above  
categories. We have our manufacturing setup which is located in  
Pakistan. We are manufacturing all our items in our factory. Our  
average production capacity is 40000-50000 pieces per month. We have  
more than 300 skilled staff which are working hard for the success of  
the company. We have rich export experience and export qualification,  
according to your market throughout and adjustment. We insist on  
providing our customers with best quality, competitive prices and the  
best services including fast delivery. Our mission is to help our  
customers to pursue their passion by providing them with the best  
quality products and services.
We are hoping that you will give us a chance to take advantage of our  
rich experience in this line.
Thank you in advance and we look forward to hearing from your side very soon.
Kind Regards,
Chief Executive,
Muhammad Jawad
Race Zone International, Defense Road, Sialkot-Pakistan
Web:www.racezone.biz
Email: info@racezone.biz
                sales@racezone.biz
WhatsApp: +92-310-7247897
Mobile: +92-310-7247897


