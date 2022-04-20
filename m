Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A165080A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359439AbiDTFgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359424AbiDTFgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:36:32 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3074537A37;
        Tue, 19 Apr 2022 22:33:39 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e128so510511qkd.7;
        Tue, 19 Apr 2022 22:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PXFvCciEg1v3tJ+47eVAWheZsHzpnwaCIbZlYeH0uJE=;
        b=HlkRl3N/UuFGxw6R+plc4wb9SFkzAqLSdKHjtRgFGYOC8M4BMcji8R2TuwTfsqZTeW
         qOfgahpjIROsrRxOkrzQAooExUEmsYa8f63CayfU3er46H9hI7aizafcGToRmsp88WrM
         pvnTxV6k+svkd6rSDnShEIn815JSwGF3foNjMGYrFWKL00CWKuQzbaJdN5jlF370lGOI
         DIqOBCKsYuEKIoH0q6/XVMd/JEK2r+zpuFndvcHF053MeouBY/ystC5JrzJ1hT0CdpMT
         9hp3hqfUmetKdGbaFjeEs+Ug4K96+o45Ln/8dMkz0uRGweHyCfd92ecHJQSW3kYY/ds5
         p5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PXFvCciEg1v3tJ+47eVAWheZsHzpnwaCIbZlYeH0uJE=;
        b=SwifjohItn5G63qPkv6nde2zjdzvtZKbFUV8b8GDivSayMefP6s7NySiAGaeFJmjW3
         M7o4SRnoaQ5UKtRj8Wirrlb4SnffaxdFFNCP/m5orELtzrVHlRNp42rDC5pWjVp7Xz+g
         zkRiRbj1/eNlOpfGTD+spec4PgPk1gh9VihtKO67GKpym74Vq4s7RFZhZCDY81Lyh7U/
         OWrfflCO/sK805JPf6dyx5+q8qHk/IdXQsT6U3wvR8rhH69YY9AH/f1RSMmaVWUE1qiq
         MihE8innoofWG56l2lbE8ARTdELhq4lCbZbza8a3pKNl9vl9sG+rWYvNoC3G2x8APuoH
         Sglw==
X-Gm-Message-State: AOAM532P+DmuzazEuuKgFY2LSKstBSuDs94wgkSl9gnE3OxokQKjg3R7
        BFXluQptTojZf4Z2wQB+BRU=
X-Google-Smtp-Source: ABdhPJzwtY8dZfflB8XOBBdkAFbGvsHFAn3xN/qgZiaDSkUSqrPOqcTdu7BvYRBIh3gkathAiu266Q==
X-Received: by 2002:a05:620a:424e:b0:67e:4c1b:c214 with SMTP id w14-20020a05620a424e00b0067e4c1bc214mr11685190qko.651.1650432818355;
        Tue, 19 Apr 2022 22:33:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:cac:ed08:b92a:3a4b? ([2600:1700:2442:6db0:cac:ed08:b92a:3a4b])
        by smtp.gmail.com with ESMTPSA id h27-20020ac8777b000000b002eff87a2c42sm1265439qtu.4.2022.04.19.22.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 22:33:37 -0700 (PDT)
Message-ID: <272758bf-5fbe-c4e2-79dc-7242d4a3a776@gmail.com>
Date:   Wed, 20 Apr 2022 00:33:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] of: overlay: rework overlay apply and remove
 kfree()s
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
References: <20220419005241.831411-1-frowand.list@gmail.com>
 <20220419005241.831411-3-frowand.list@gmail.com>
 <Yl8F+cthdYbDBdWX@robh.at.kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <Yl8F+cthdYbDBdWX@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 13:56, Rob Herring wrote:
> On Mon, Apr 18, 2022 at 07:52:41PM -0500, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Fix various kfree() issues related to of_overlay_apply().
>>   - Double kfree() of fdt and tree when init_overlay_changeset()
>>     returns an error.
>>   - free_overlay_changeset() free the root of the unflattened
>>     overlay (variable tree) instead of the memory that contains
>>     the unflattened overlay.
>>   - For the case of a failure during applying an overlay, move kfree()
>>     of new_fdt and overlay_mem into free_overlay_changeset(), which
>>     is called by the function that allocated them.
>>   - For the case of removing an overlay, the kfree() of new_fdt and
>>     overlay_mem remains in free_overlay_changeset().
> 
> You never set kfree_unsafe back to false anywhere, so after removing you 
> still leak memory.

Embarrassing and ironic that I would leave that line out.  There should
be an ovcs->kfree_unsafe = false immediately before
"overlay_notify(ovcs, OF_OVERLAY_POST_REMOVE)" in of_overlay_remove().

> 
>>   - Check return value of of_fdt_unflatten_tree() for error instead
>>     of checking the returned value of overlay_root.
>>   - When storing pointers to allocated objects in ovcs, do so as
>>     near to the allocation as possible instead of in deeply layered
>>     function.
>>
>> More clearly document policy related to lifetime of pointers into
>> overlay memory.
>>
>> Double kfree()
>> Reported-by: Slawomir Stepien <slawomir.stepien@nokia.com>
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> Changes since v2:
>>   - A version 2 review comment correctly said "This screams hack".
>>     Restructure as listed below in response to the comment.
>>   - Quit passing kfree_unsafe in function parameters, move it to
>>     be a field of ovcs
> 
> What I meant was store the notifier state and from that imply when kfree 
> is unsafe. Something like this patch on top of yours (untested and still 
> some kfree_unsafe comments need to be updated):

Got it.  I like the approach you show below.  Patch v4 should be appearing
Tuesday.

-Frank

> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 3072dfeca8e8..53c616f576d2 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -63,7 +63,7 @@ struct fragment {
>   * @count:		count of fragment structures
>   * @fragments:		fragment nodes in the overlay expanded device tree
>   * @symbols_fragment:	last element of @fragments[] is the  __symbols__ node
> - * @kfree_unsafe:	pointers into the @new_fdt or @overlay_mem may exist
> + * @notify_state:	the last successful notifier called
>   * @cset:		changeset to apply fragments to live device tree
>   */
>  struct overlay_changeset {
> @@ -75,7 +75,7 @@ struct overlay_changeset {
>  	int count;
>  	struct fragment *fragments;
>  	bool symbols_fragment;
> -	bool kfree_unsafe;
> +	enum of_overlay_notify_action notify_state;
>  	struct of_changeset cset;
>  };
>  
> @@ -183,6 +183,8 @@ static int overlay_notify(struct overlay_changeset *ovcs,
>  		}
>  	}
>  
> +	ovcs->notify_state = action;
> +
>  	return 0;
>  }
>  
> @@ -831,6 +833,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs)
>  	}
>  
>  	ovcs->count = cnt;
> +	ovcs->notify_state = OF_OVERLAY_INIT;
>  
>  	return 0;
>  
> @@ -866,15 +869,14 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>  	 * allowed to retain pointers into the overlay devicetree other
>  	 * than during the window between OF_OVERLAY_PRE_APPLY overlay
>  	 * notifiers and the OF_OVERLAY_POST_REMOVE overlay notifiers.
> -	 * During the window, ovcs->kfree_unsafe will be true.
>  	 *
>  	 * A memory leak will occur here if ovcs->kfree_unsafe is true.
>  	 */
>  
> -	if (!ovcs->kfree_unsafe)
> +	if (ovcs->notify_state == OF_OVERLAY_INIT || ovcs->notify_state == OF_OVERLAY_POST_REMOVE) {
>  		kfree(ovcs->overlay_mem);
> -	if (!ovcs->kfree_unsafe)
>  		kfree(ovcs->new_fdt);
> +	}
>  	kfree(ovcs);
>  }
>  
> @@ -926,12 +928,6 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
>  	if (ret)
>  		goto out;
>  
> -	/*
> -	 * After overlay_notify(), ovcs->overlay_root related pointers may have
> -	 * leaked to drivers, so can not kfree() ovcs->overlay_mem and
> -	 * ovcs->new_fdt until after OF_OVERLAY_POST_REMOVE notifiers.
> -	 */
> -	ovcs->kfree_unsafe = true;
>  	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
>  	if (ret) {
>  		pr_err("overlay changeset pre-apply notify error %d\n", ret);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 04971e85fbc9..b7b095593eec 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1543,6 +1543,7 @@ static inline bool of_device_is_system_power_controller(const struct device_node
>   */
>  
>  enum of_overlay_notify_action {
> +	OF_OVERLAY_INIT = -1,
>  	OF_OVERLAY_PRE_APPLY = 0,
>  	OF_OVERLAY_POST_APPLY,
>  	OF_OVERLAY_PRE_REMOVE,

