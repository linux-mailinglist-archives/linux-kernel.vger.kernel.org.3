Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D604B480970
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhL1NJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhL1NJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:09:36 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4EAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 05:09:35 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h15so17221332ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 05:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=raZYs6hq+w01uYhTxQ4dt0lfSN7FKbl65aoYpDo2wa8=;
        b=bMBBF+IboANSYzFd+cuwV6TxaR/XwMgsJdhl2WQWVGCrLoBSnuGjU6HrTmQPUJQdW2
         TowygMK2oeduJTG6NfRDCaTRPFHyDtjjB9k69Qcd/AOgWIHTWGM+evA7Z3l875/yRj62
         emg3etkFgXmlp3CTAtlNivL8U9phUDiCJYG+cdZPqX1/wquNyF7gy0wnsVzLSao2FrlH
         QXCaMI9tmRHOsM40kjeNYNBYwufh6UaKWljTwQd2iVkKI6veZiRuyGKEGCZe26b3FiF7
         7GDhsnKYByg6wcAo/pQkA4fYwy4HFGxZNDl9qt+TGOL7MzAjvx6khhouGxwTg9+NWim8
         HBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=raZYs6hq+w01uYhTxQ4dt0lfSN7FKbl65aoYpDo2wa8=;
        b=KmtXXqcfboeAkzGqI8Tt0b9Sb9cyBq5yPx44qwp/ayVAYVyvZlLg0gte7CyclGPlrQ
         oJ9A3o+BVmT9NGEzLTt/hQiiyu5oWcRThI9AWy76QugwcNgu6apoy1fSU021Opo+s6By
         /pZb4zuA9hz3I+fE328jtLA/V+JJ5ip383E/0UC7gvCF/rqeaB/wPI4jMx7Jv8cqOKy9
         a79pwBy/8W+iYfQz6VIYC8AVIoRlhyejzso3dYPVgKWDpo+GjnFPv2B6hHBz4WPmK4A7
         8WytkIxc73WB4n98Vd+w8l2R3EkooIKJj9t9XThEMkKB0zJVpV3t0EODTlHk6XajeM+V
         orag==
X-Gm-Message-State: AOAM531f9WMqR9DTL/00PV0HHCyDGCqgw/d6str9wqLk4Yv6XSifVzw0
        uH9Yo2CBqpPRVVYXMwg4fCjUxw==
X-Google-Smtp-Source: ABdhPJx6u+jzmEuwoiD+u5NjUBn0UWuE/FLrFW8oSRkmquZSTQh17QJmENKS/N2RyuHXxjKT9tpjEw==
X-Received: by 2002:a05:651c:1993:: with SMTP id bx19mr2085421ljb.472.1640696973673;
        Tue, 28 Dec 2021 05:09:33 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u3sm908644ljo.95.2021.12.28.05.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 05:09:33 -0800 (PST)
Message-ID: <78491489-6b31-c741-8c69-8d52fb614a6c@linaro.org>
Date:   Tue, 28 Dec 2021 16:09:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/8] device property: Helper to match multiple connections
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
 <20211228052116.1748443-4-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20211228052116.1748443-4-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2021 08:21, Bjorn Andersson wrote:
> In some cases multiple connections with the same connection id
> needs to be resolved from a fwnode graph.
> 
> One such example is when separate hardware is used for performing muxing and/or
> orientation switching of the SuperSpeed and SBU lines in a USB-C
> connector. In this case the connector needs to belong to a graph with
> multiple matching remote endpoints, and the TypeC controller needs to be
> able to resolve them both.
> 
> Add a new API that allows this kind of lookup.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/base/property.c  | 94 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/property.h |  5 +++
>   2 files changed, 99 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index cbe4fa298413..0aa0296fd991 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1180,6 +1180,36 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>   	return NULL;
>   }
>   
> +static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> +						const char *con_id, void *data,
> +						devcon_match_fn_t match,
> +						void **matches,
> +						unsigned int matches_len)
> +{
> +	struct fwnode_handle *node;
> +	struct fwnode_handle *ep;
> +	unsigned int count = 0;
> +	void *ret;
> +
> +	fwnode_graph_for_each_endpoint(fwnode, ep) {
> +		if (count >= matches_len) {
> +			fwnode_handle_put(ep);
> +			return count;
> +		}
> +
> +		node = fwnode_graph_get_remote_port_parent(ep);
> +		if (!fwnode_device_is_available(node))
> +			continue;
> +
> +		ret = match(node, con_id, data);
> +		fwnode_handle_put(node);
> +
> +		if (ret)
> +			matches[count++] = ret;
> +	}
> +	return count;
> +}

This API doesn't let it's user know if there are more matches found in 
the device tree or not. I'd suggest to add 'count' mode that would 
return the amount of found matches if (matches == NULL) && (matches_len 
== 0).

> +
>   static void *
>   fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>   		    void *data, devcon_match_fn_t match)
> @@ -1202,6 +1232,35 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>   	return NULL;
>   }
>   
> +static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
> +					  const char *con_id, void *data,
> +					  devcon_match_fn_t match,
> +					  void **matches,
> +					  unsigned int matches_len)
> +{
> +	struct fwnode_handle *node;
> +	unsigned int count = 0;
> +	void *ret;
> +	int i;
> +
> +	for (i = 0; ; i++) {
> +		if (count >= matches_len)
> +			return count;
> +
> +		node = fwnode_find_reference(fwnode, con_id, i);
> +		if (IS_ERR(node))
> +			break;
> +
> +		ret = match(node, NULL, data);
> +		fwnode_handle_put(node);
> +
> +		if (ret)
> +			matches[count++] = ret;
> +	}
> +
> +	return count;
> +}
> +

Same comment applies.

>   /**
>    * fwnode_connection_find_match - Find connection from a device node
>    * @fwnode: Device node with the connection
> @@ -1229,3 +1288,38 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
>   	return fwnode_devcon_match(fwnode, con_id, data, match);
>   }
>   EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
> +
> +/**
> + * fwnode_connection_find_matches - Find connections from a device node
> + * @fwnode: Device node with the connection
> + * @con_id: Identifier for the connection
> + * @data: Data for the match function
> + * @match: Function to check and convert the connection description
> + * @matches: Array of pointers to fill with matches
> + * @matches_len: Length of @matches
> + *
> + * Find up to @matches_len connections with unique identifier @con_id between
> + * @fwnode and other device nodes. @match will be used to convert the
> + * connection description to data the caller is expecting to be returned
> + * through the @matches array.
> + *
> + * Return: Number of matches resolved, of negative errno.
> + */
> +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> +				   const char *con_id, void *data,
> +				   devcon_match_fn_t match,
> +				   void **matches, unsigned int matches_len)
> +{
> +	unsigned int count;
> +
> +	if (!fwnode || !match || !matches)
> +		return -EINVAL;
> +
> +	count = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> +					    matches, matches_len);
> +
> +	return count + fwnode_devcon_matches(fwnode, con_id, data, match,
> +					     matches + count,
> +					     matches_len - count);
> +}
> +EXPORT_SYMBOL_GPL(fwnode_connection_find_matches);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 16f736c698a2..59484ccb260e 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -444,6 +444,11 @@ static inline void *device_connection_find_match(struct device *dev,
>   	return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
>   }
>   
> +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> +				   const char *con_id, void *data,
> +				   devcon_match_fn_t match,
> +				   void **matches, unsigned int matches_len);
> +
>   /* -------------------------------------------------------------------------- */
>   /* Software fwnode support - when HW description is incomplete or missing */
>   


-- 
With best wishes
Dmitry
