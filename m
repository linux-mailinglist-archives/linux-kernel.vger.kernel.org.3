Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64364B1496
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbiBJRvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:51:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245319AbiBJRvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:51:11 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181B10EA;
        Thu, 10 Feb 2022 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QxL1pJKb53w2Gb5rIykQPgNfZM69s8I4TUvEwQwyuHE=; b=iL97dKlXtgf81M+2YQnKcpo3dO
        th521AxOI80rVKxUx/K0dr/QG1cqkciuoT1WlSfDEInQX+H3QTIcNDf1teV6ONFTzIVVLadBkjBD2
        icy4Ltc9yQoPY19bX7E/KxDfsT9dUBH26NFC89kVDHz32EHugdlpQg58YK83KL7e2vCKSdhfFZi6P
        GyrV4+C5osCv5iZ5RNVo2tNdx1aoBdWdvCZ8AqOrVTrywUbFSSpEws5bAeRF4MzBMDQ6aj4qO+ifr
        bXCjE9TVoaE+K3x9kC8Dh2P+U+81NIk+vhF7ZaDnY//pAgePqLbnlzIap5aiLehG6u2zLpixk/uu5
        7yNd62zw==;
Received: from 201-27-34-10.dsl.telesp.net.br ([201.27.34.10] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nIDat-0005V2-Jh; Thu, 10 Feb 2022 18:51:00 +0100
Message-ID: <f76afc7d-487e-f76c-2ad6-509398b25888@igalia.com>
Date:   Thu, 10 Feb 2022 14:50:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "bhe@redhat.com" <bhe@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
 <e2d39675-5df6-73fb-fa24-df906a97ee50@igalia.com>
 <YgMLd+avxyBplfk2@MiWiFi-R3L-srv>
 <7b45bc2b-f74d-8604-bd8a-4930f7b8f926@igalia.com>
 <MWHPR21MB1593C36268FFB3FD654074A5D72F9@MWHPR21MB1593.namprd21.prod.outlook.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <MWHPR21MB1593C36268FFB3FD654074A5D72F9@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 14:26, Michael Kelley (LINUX) wrote:
> From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Thursday, February 10, 2022 8:40 AM
> [...]>> I'll need to study the Hyper-V code and how it's done today -
> 
> Let me know if you need any assistance or explanation as you look
> at the Hyper-V code.
>
Perfect Michael, thanks a lot! Much appreciated =)
