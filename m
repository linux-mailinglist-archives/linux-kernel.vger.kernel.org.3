Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99784526F35
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiENC5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiENCzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:55:36 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3DF3427AA;
        Fri, 13 May 2022 19:41:38 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso12424808pjw.0;
        Fri, 13 May 2022 19:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ruNVL6DayK6ln7TndvoBaHbZun5aJyL13XuWbDCegG0=;
        b=y06J1wAy8jNk0IoC+Se/QSI2nZbpb5LVap+m2F5xuPMCj0k4G5P4011SHfvN4zysWg
         azug38qlND8sdDK97F0TZdvWAPXVsx24sukfNaIkBtUYtTEvl5JOHW48tomDhDdrruAn
         Yi+XMvGalMAeKOEwh18SOi81d9L3wXXCIqZgKWwPw1vbStcCLQbwbJzMS+222+fF8W1A
         ofWHUxXCMm8xop7w5pSAQF/p7IDa0522IWkye9GTVaSRoowbpxlk/b2GNFIHJaTxrvX4
         2ZpXHdl1DXYgrtlpfDKPtC4nv/UoqK0nvN71ktXnH75rkxVVRJ1kSWVaI8wRcYraGfoD
         mJTw==
X-Gm-Message-State: AOAM533c3KKnR9zMPBvjzKXUNPnTTdD5+M5hUyx9gvVSUvrNBDHrNLiy
        ataJTA8O/veL1b7zdjjXiJA=
X-Google-Smtp-Source: ABdhPJyILAujfkR+f4aG7ZVSsJIkaeu+GmGudqvdunSorB2oGvvzIVNHRhdSPE1nLC9p3a+9IC14Iw==
X-Received: by 2002:a17:90b:2311:b0:1d9:2e43:c7ae with SMTP id mt17-20020a17090b231100b001d92e43c7aemr18944133pjb.47.1652496098092;
        Fri, 13 May 2022 19:41:38 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902848e00b0015e8da1f9e8sm2537827plo.77.2022.05.13.19.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 19:41:37 -0700 (PDT)
Message-ID: <7e12e950-fece-845f-6784-d3e59480f810@acm.org>
Date:   Fri, 13 May 2022 19:41:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH linux-next] scsi: target: cxgbit: replace ternary operator
 with min()
Content-Language: en-US
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Christie <michael.christie@oracle.com>,
        Varun Prakash <varun@chelsio.com>,
        "open list:SCSI TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:SCSI TARGET SUBSYSTEM" <target-devel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
References: <20220512133754.40849-1-guozhengkui@vivo.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220512133754.40849-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 06:37, Guo Zhengkui wrote:
> diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> index 3336d2b78bf7..6d9a13da6cb7 100644
> --- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> +++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> @@ -1008,7 +1008,7 @@ int cxgbit_ofld_send(struct cxgbit_device *cdev, struct sk_buff *skb)
>   	ret = cxgb4_ofld_send(cdev->lldi.ports[0], skb);
>   	if (ret < 0)
>   		kfree_skb(skb);
> -	return ret < 0 ? ret : 0;
> +	return min(ret, 0);
>   }
>   
>   static void cxgbit_release_tid(struct cxgbit_device *cdev, u32 tid)
> @@ -1039,7 +1039,7 @@ cxgbit_l2t_send(struct cxgbit_device *cdev, struct sk_buff *skb,
>   	ret = cxgb4_l2t_send(cdev->lldi.ports[0], skb, l2e);
>   	if (ret < 0)
>   		kfree_skb(skb);
> -	return ret < 0 ? ret : 0;
> +	return min(ret, 0);
>   }
>   
>   static void cxgbit_send_rx_credits(struct cxgbit_sock *csk, struct sk_buff *skb)

I prefer to keep the existing code since "return min(ret, 0)" is not how 
humans write kernel code.

Thanks,

Bart.
