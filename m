Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECF64BC265
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiBRV62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:58:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiBRV6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:58:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958B60CC7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rTFlTPx7C6Iu63CArqpOV0QwSimp1W7D9+7MJYR1hyA=; b=KyikYNygb1kjOzDj1BtAKK5G1q
        yl9KFI/qV15w1zZDlVc0m4RLkplSvYk1s/QkDSqd56vPz7nLh2jjc1E9gxAojdqkKKCFF7MQ1nbo5
        uZvBUlfT/aM/dKGT5wFkWdNC5nj1ywVDJkJYTL5hW0m9Br0yrcK5Cr3iUCX+hTd751F9YhJKlJQmk
        747oyDTiPe4HZI6ZPjytuxOuAg9e0H4rk8PUFYtuhqUGMA4Zn4f5LR2zHmyCloy8Jv+U3uslzKLcE
        BKy0ANUGU0cWqyuCKhdTsQ83K45wBM59G3uf6EK00X5JXSLzPuYY4OO4uLWZb5NCdTK/uL6nXv7ua
        Xw2zmXlg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLBGO-00AvAg-Ex; Fri, 18 Feb 2022 21:58:04 +0000
Message-ID: <858a2b13-64e1-99bc-e2f7-5b2477bb1126@infradead.org>
Date:   Fri, 18 Feb 2022 13:57:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: fallthrough question
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I expected this to produce a fallthrough warning, but it doesn't
(with gcc 11.1.0):

from sound/oss/dmasound/dmasound_core.c:#1481, when falling from case 1
into case 0: (in arch/m68k/ selected builds only)

	case 1:
		if ((size = ints[2]) < 256) /* check for small buffer specs */
			size <<= 10 ;
                if (size < MIN_BUFSIZE || size > MAX_BUFSIZE)
                        printk("dmasound_setup: invalid write buffer size, using default = %d\n", writeBufSize);
                else
                        writeBufSize = size;
	case 0:
		break;
	default:

Can you tell me what is going on here?

thanks.
-- 
~Randy
