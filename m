Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D475A950D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiIAKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiIAKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:49:42 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809831314CD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:49:36 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id c7so15134666wrp.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WjC5MMmeXT3QbFNucFQXnhs+/PC/vM67wXqw/sIvdOk=;
        b=Fjb9MFmyIEwe6BedeBlXuvpiWm3+dZtgijrHSCz03QwuRuJep/UzhiubG0yjH6wTmr
         SWbnoIWOgZ9FOTLi+VhBH9/4zfT4Pvwvbn8lT+H9ByIFvSVcLEvUmYsWTMLVQd0+ZuEd
         DSIoXB94IcM9/pecc9XoD3a51cM0Yr/m7keedVX0kIYw4EZV7SP8hhvK5cxdzfeapV9B
         N6ji7Ctz8o9g3QnzUMsgQLyt6V28BZehShiwdj2s4sgkqaoSJblZ4KHZe1EKdWtztBdA
         sX797DvG3a6pob5BhWjctDWURHpgV2w8q1MMkB6/4qT+XuKkeqaYvVcXFvORON2FkwXW
         uZXQ==
X-Gm-Message-State: ACgBeo1xg+9HuYAG9G6AJo0+NXQ46y4KJj2ngOcKZPQgtzNDqJoior+2
        G/bcu+apORITOzRQwg86+8rID0YRHDs=
X-Google-Smtp-Source: AA6agR6XN6fPghRY6m4UvfSO/a5VgaXvSdaPKgEJQvnTeiC3Bbq5mbrSMkaXumOd0Qm7oJF4IfpbCQ==
X-Received: by 2002:adf:f911:0:b0:21e:c0f6:fd26 with SMTP id b17-20020adff911000000b0021ec0f6fd26mr14153824wrr.361.1662029375141;
        Thu, 01 Sep 2022 03:49:35 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q28-20020a056000137c00b002205cbc1c74sm14250469wrz.101.2022.09.01.03.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 03:49:33 -0700 (PDT)
Message-ID: <62e78a2f-998a-b340-9dcd-7d5c12c96fe9@grimberg.me>
Date:   Thu, 1 Sep 2022 13:49:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drivers/nvme/host: Fix namespace duplication check
 rule
Content-Language: en-US
To:     sungup.moon@samsung.com, "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220901002815epcms2p6ae137d9de49bef5764f19c0fa7f3536e@epcms2p4>
 <20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca@epcms2p4>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220901004941epcms2p4e5e1c53484889619f050a02d8e671eca@epcms2p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/22 03:49, Sungup Moon wrote:
> Some NVMe device, use EUI64 and NGUID, has fixed value EUI64 on a
> sub-system because of the bit size of ID. Current kernel check the
> all IDs should have unique value in a sub-system and globally.
> However, if an namespace has duplicate IDs (not all) in a sub-system,
> current kernel raise "duplicate IDs in subsystem for nsid" error. But
> NVMe Specification defines the namespace unique identifier like this:
> 
> When creating a namespace, the controller shall indicate a globally
> unique value in one or more of the following:
> a) the EUI64 field;
> b) the NGUID field; or
> c) a Namespace Identification Descriptor with the Namespace Identifier
> Type field set to 3h
> (reference: 7.11 Unique Identifier; NVM Express 1.4c spec)
> 
> So, I suggest the modified nvme_subsys_check_duplicate_ids function
> checking uniqueness from all IDS to one more IDs.
> 
> I missed the initializing of "duplicated" variable, so I reissue the
> version2 patch.
> 
> Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
> ---
>   drivers/nvme/host/core.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index af367b22871b..8c2faa2881a4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3902,24 +3902,35 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>          return NULL;
>   }
> 
> +#define IDS_EQUAL(A, B) (memcmp(&(A), &(B), sizeof(A)) == 0)

No need for this macro IMO.

> +
>   static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
>                  struct nvme_ns_ids *ids)
>   {
>          bool has_uuid = !uuid_is_null(&ids->uuid);
>          bool has_nguid = memchr_inv(ids->nguid, 0, sizeof(ids->nguid));
>          bool has_eui64 = memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
> +       bool duplicated;
>          struct nvme_ns_head *h;
> 
>          lockdep_assert_held(&subsys->lock);
> 
>          list_for_each_entry(h, &subsys->nsheads, entry) {
> -               if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
> -                       return -EINVAL;
> -               if (has_nguid &&
> -                   memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
> -                       return -EINVAL;
> -               if (has_eui64 &&
> -                   memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
> +               duplicated = has_uuid || has_nguid || has_eui64;
> +
> +               if (has_uuid)
> +                       duplicated = duplicated &&
> +                               uuid_equal(&ids->uuid, &h->ids.uuid);
> +
> +               if (has_nguid)
> +                       duplicated = duplicated &&
> +                               IDS_EQUAL(ids->nguid, h->ids.nguid);
> +
> +               if (has_eui64)
> +                       duplicated = duplicated &&
> +                               IDS_EQUAL(ids->eui64, h->ids.eui64);
> +
> +               if (duplicated)
>                          return -EINVAL;

That is very confusing.

So a ns can have an identifier that does not have to be unique? or that
every identifier that exist should be unique but at least one identifier
should exist?

The former seems weird...
