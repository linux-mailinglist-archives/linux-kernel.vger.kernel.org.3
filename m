Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6574795F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbhLQVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbhLQVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:02:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B11C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:02:06 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q17so2868543plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zb80lUtz8TIrMwIl8Mq7TS3TuTjpivrPThPX+10XdfI=;
        b=H7dQafYYV6AiiOtbuD+6XV6BxfKK9UXz1nH2YDo5PmPeXuQmIVNeFhyBMz7dXDSf8S
         ai2UWX8rWnkEKgnyzjbNnY3ttEWquajMdfZTnvHHG7ufmASztW7QpiLgDlQvbcZH4wyi
         bJX6+eJBgRRIUQPvAsDNYc0GA2eyEksOHVmQDv60AYcVRW4qdmZpyEIT3YN9rB/ehrwt
         zYQg7CYSSUegjuJyBpDGhbXPyaW7XpEmKIzHnzduT4xNfjjfTjlxygyICxLP3Q4UaoRd
         Rv9X3KYShDAsqEnpl2c+mFOkMD9gK4ILBrmk7NQXhSmBJXklc34vhpxJJmV2n/5Dya1J
         RCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zb80lUtz8TIrMwIl8Mq7TS3TuTjpivrPThPX+10XdfI=;
        b=lpetwoK4Gvc7oiK8af9qBDx2zJY8n6eRAJ79XClaH5gBGkbi5Bttf7QCqMkQKBAExD
         IAl6TXYIqWpXfUjns7u5S+vrwu0277fpS54wCn/y+xMkSqhMQ5ZE+bWLA6J+IkRDkWEo
         E/8Smi7W8W1hhL2P5HZqdo87EF4Bu+MhMiTBK0K3JDLygoJvzB9OmQXBBJdsrDvn+bt9
         5eJtVMi5LbjE/QzznXTcb6OK7Rj05ksX6B+LAKS2CqTfcLznIXukLBEgXQKCZwS2m5ux
         JuPPBMmaCTI4SNpgbyPm03qdmcSAZTuZjZ8eVBaBrO6I8pLtLikDHA4MiV3LU0qIQNwp
         h0pA==
X-Gm-Message-State: AOAM533DRx4Mw1IR/75fUDrxMHN6Z7Lar937hEBUuIPj0yu6qn9JjMHU
        7jHc8u92lUUPIpmXis9EM8OEOIwi6wqqTQ==
X-Google-Smtp-Source: ABdhPJx3vvWuEHUqFG5EEydz2bNM2b6Br0aLcEErjqjr1tQXxas8MSJ7fFt0mGEBewXigJzS4qn1Ug==
X-Received: by 2002:a17:902:9a43:b0:148:9d8b:bead with SMTP id x3-20020a1709029a4300b001489d8bbeadmr4952878plv.76.1639774926165;
        Fri, 17 Dec 2021 13:02:06 -0800 (PST)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id c7sm5314519pjs.17.2021.12.17.13.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 13:02:05 -0800 (PST)
Date:   Fri, 17 Dec 2021 13:02:03 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yevhen Orlov <yevhen.orlov@plvision.eu>
Cc:     netdev@vger.kernel.org,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Mickey Rachamim <mickeyr@marvell.com>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        Taras Chornyi <tchornyi@marvell.com>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net: marvell: prestera: Register inetaddr
 stub notifiers
Message-ID: <20211217130203.537f6dc9@hermes.local>
In-Reply-To: <20211217195440.29838-6-yevhen.orlov@plvision.eu>
References: <20211217195440.29838-1-yevhen.orlov@plvision.eu>
        <20211217195440.29838-6-yevhen.orlov@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 21:54:37 +0200
Yevhen Orlov <yevhen.orlov@plvision.eu> wrote:

> +
> +static int __prestera_inetaddr_valid_cb(struct notifier_block *nb,
> +					unsigned long event, void *ptr)
> +{
> +	struct in_validator_info *ivi = (struct in_validator_info *)ptr;
> +	struct net_device *dev = ivi->ivi_dev->dev;
> +	struct prestera_router *router = container_of(nb,
> +						      struct prestera_router,
> +						      inetaddr_valid_nb);
> +	struct in_device *idev;
> +	int err = 0;
> +
> +	if (event != NETDEV_UP)
> +		goto out;
> +
> +	/* Ignore if this is not first address */
> +	idev = __in_dev_get_rtnl(dev);
> +	if (idev && idev->ifa_list)
> +		goto out;
> +
> +	if (ipv4_is_multicast(ivi->ivi_addr)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	err = __prestera_inetaddr_event(router->sw, dev, event, ivi->extack);
> +out:
> +	return notifier_from_errno(err);
> +}

Your router is quite limited if it only can handle a single unicast address.
