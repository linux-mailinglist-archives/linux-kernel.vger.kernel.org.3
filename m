Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3557E58F1A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiHJRfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHJRfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:35:46 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DE258B6F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:35:45 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id CBBE3240105
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660152943; bh=XrwCglE9bKXMgEZnO62BEsdmCMy5RjaDtuIUp+Juvxw=;
        h=Date:From:To:Cc:Subject:From;
        b=MHEooSvmk1OPETItSd7jtOSLB6RW7JLBi17zVdcTBk9LZoL2r/JaCPHJ/FTZXO2Iu
         brC/Z1XFGfjDoVAizB9if14/pszEMCd3/O4vGZBoc5x7VU2f5PPm93P8SVyy2EbuOw
         +kv3tgxYypsXL+cHk9bw1+KZFhB8vyWOnyqSYh1MvziIDYuYMjC+J1AxGAiycKleKG
         C+YXmqxW7smWs2F/4vwXLYQSRSVUoUHh2gItU4a0aMdMg6pGiZt0OQ/EUhQlSsQ1Hk
         UNVA5FdpdlZSPaapne5pfNgE9+JQAu43cX7Xsk0kkNRr4mHtuFAbSpPyNhNI0xLz2x
         8wj/cCSMMyeKQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M2xt65cPKz9rxQ;
        Wed, 10 Aug 2022 19:35:42 +0200 (CEST)
Date:   Wed, 10 Aug 2022 17:35:41 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
Message-ID: <20220810193541.29f95ec5@posteo.net>
In-Reply-To: <20220810133012.GB274220@roeck-us.net>
References: <YvN4SbnAp3jl+Vzo@monster.localdomain>
        <20220810133012.GB274220@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 06:30:12 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> > +static int ocpmode_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct corsairpsu_data *priv = seqf->private;
> > +	long val;
> > +	int ret;
> > +
> > +	ret = corsairpsu_get_value(priv, PSU_CMD_OCPMODE, 0, &val);
> > +	if (ret < 0)
> > +		seq_puts(seqf, "N/A\n");
> > +	else
> > +		seq_printf(seqf, "%s\n", (val == 0x02) ? "multi rail" : "single rail");
> 
> If this is not always available, would it be better not to create the file
> in the first place ? If that is not feasible, it should at least be
> documented that the value is not always available to ensure that no one
> complains about it (or at least no one who read the documentation).
> 
> Also, is the value strictly 0x02 for multi-rail configurations, or
> is that possibly just a bit or the number of rails ?

The mode is actually switchable on fly, similar to the fan. I do not want to
provide the switching functionality, because also similar to the fan controls,
it can be used to damage the PSU. It is part of the over current protection
system (hence the name ocpmode) and people use the RAW interface to switch the
fans and the ocpmode. This is also the reason I made it that way, because you
could poll the information right in the process of switching, which can result
in bogus values. 0x02 is the value for "switching to multi rail was successful",
every other value is considered "single rail mode". Or you get a malformed
message which results in "N/A" or unknown. So yes, you are right, I could at
least add a define for the value and be more clear in the documentation. Would
that be okay for you?

greetings,
Wilken
