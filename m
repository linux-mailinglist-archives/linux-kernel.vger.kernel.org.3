Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8DA56BB33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiGHNwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiGHNv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05DF91C903
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657288315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVefCn2Sr2XDtcSF1e802d6x0OPOMy5L9rDF1Zp3WNI=;
        b=g5RKiSaLNTJsuN+HoWqeC8Vy+A9ukQ2LYcJj3XhpeQf8S/Ixs4FynpTytVjGhV/v4cb+wn
        Pu2JYbs7JlFecnAX83mj0UrrLZLLGPb+08Gli6+P2ieYpcjT/hkGEaP8a7T6RHaAHtz3ys
        9Ja8+1KD6ISCP2kiTqYYfPUtMNIWtGc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-oWvo6nq7MbCZdA-mLH1OYg-1; Fri, 08 Jul 2022 09:51:53 -0400
X-MC-Unique: oWvo6nq7MbCZdA-mLH1OYg-1
Received: by mail-qt1-f200.google.com with SMTP id a7-20020ac84347000000b00319bb5d130eso18569797qtn.14
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 06:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yVefCn2Sr2XDtcSF1e802d6x0OPOMy5L9rDF1Zp3WNI=;
        b=GeLSRGd/QwMbxoO6e9WSGjpbW1hlxDH6OB48ztqcwYidr2aKtbqGiE+Od5VAaBMt0n
         br+2bXqH47aCrRFGKfBOQZocj5pKQnOzNyAynb48imm1q4KulagxaLiZWuGI/BkQ1zgu
         wDB4XocpPFLo8UY6eqgYA6KJnWV1DZ8+hQ0Un6NX5i4cSH5fX5OPNTYwzFey8O0nyIyl
         iiukvpdwIwQgNUKKkv3fyu3QmRoc1kH6gz1UJu9zBukLoWBOuSYaRpOkvdd0xc+N1IWG
         uix4wSgFmrbnwroAHnzdB6g/2AFI60OQiXsypQpbT8atYDn+Wn0NiNk6rG2u+G+/ht6b
         Q/Ow==
X-Gm-Message-State: AJIora9pKaVpF1Z6H0J9cHmyY7FdhSbeg28qGWABdqltMYYq+SScusgs
        1332Fh/r8sJW7DDCpTwTb9pS1zy6lY5JqBbd7ffh/ObeljZDYJdkmVCNCRHbe/3HMLfg61W4nMR
        Jx+YVB9O1LcsYJ+AwqVRuuisH
X-Received: by 2002:a05:6214:20ea:b0:473:421d:d459 with SMTP id 10-20020a05621420ea00b00473421dd459mr1714714qvk.27.1657288313016;
        Fri, 08 Jul 2022 06:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s9HR4FiVcyVsBfX00aQKPJWG12vBD+uxGxuwJDaIa2y0QoQQjiF0NRy0pY+w9XGYubd8flkg==
X-Received: by 2002:a05:6214:20ea:b0:473:421d:d459 with SMTP id 10-20020a05621420ea00b00473421dd459mr1714693qvk.27.1657288312809;
        Fri, 08 Jul 2022 06:51:52 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id t14-20020a05620a004e00b006a6d20386f6sm31658212qkt.42.2022.07.08.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:51:50 -0700 (PDT)
Date:   Fri, 8 Jul 2022 15:51:38 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     netdev <netdev@vger.kernel.org>, Jason Wang <jasowang@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Cindy Lu <lulu@redhat.com>,
        "Kamde, Tanuj" <tanuj.kamde@amd.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        "Uminski, Piotr" <Piotr.Uminski@intel.com>,
        habetsm.xilinx@gmail.com, "Dawar, Gautam" <gautam.dawar@amd.com>,
        Pablo Cascon Katchadourian <pabloc@xilinx.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Longpeng <longpeng2@huawei.com>,
        Dinan Gunawardena <dinang@xilinx.com>,
        Martin Petrus Hubertus Habets <martinh@xilinx.com>,
        Martin Porter <martinpo@xilinx.com>,
        Eli Cohen <elic@nvidia.com>, ecree.xilinx@gmail.com,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Harpreet Singh Anand <hanand@xilinx.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Zhang Min <zhang.min9@zte.com.cn>
Subject: Re: [PATCH v6 2/4] vhost-vdpa: introduce SUSPEND backend feature bit
Message-ID: <20220708135138.kjdnnxelgll2p3cv@sgarzare-redhat>
References: <20220623160738.632852-1-eperezma@redhat.com>
 <20220623160738.632852-3-eperezma@redhat.com>
 <20220628134340.5fla7surd34bwnq3@sgarzare-redhat>
 <CAJaqyWd8yNdfGEDJ3Zesruh_Q0_9u_j80pad-FUA=oK=mvnLGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWd8yNdfGEDJ3Zesruh_Q0_9u_j80pad-FUA=oK=mvnLGQ@mail.gmail.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 01:38:45PM +0200, Eugenio Perez Martin wrote:
>On Tue, Jun 28, 2022 at 3:43 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Thu, Jun 23, 2022 at 06:07:36PM +0200, Eugenio Pérez wrote:
>> >Userland knows if it can suspend the device or not by checking this feature
>> >bit.
>> >
>> >It's only offered if the vdpa driver backend implements the suspend()
>> >operation callback, and to offer it or userland to ack it if the backend
>> >does not offer that callback is an error.
>>
>> Should we document in the previous patch that the callback must be
>> implemented only if the drive/device support it?
>>
>
>It's marked as optional in the doc, following other optional callbacks
>like set_group_asid for example. But I'm ok with documenting this
>behavior further.
>
>> The rest LGTM although I have a doubt whether it is better to move this
>> patch after patch 3, or merge it with patch 3, for bisectability since
>> we enable the feature here but if the userspace calls ioctl() with
>> VHOST_VDPA_SUSPEND we reply back that it is not supported.
>>
>
>I'm fine with moving it, but we will have that behavior with all the
>devices anyway. Regarding userspace, we just replace ENOIOCTL with
>EOPNOTSUPP. Or I'm missing something?

Yep, you're right, this is fine! ;-)

Stefano

