Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BF24A891D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243412AbiBCQxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:53:45 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:33317 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiBCQxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:53:43 -0500
Received: by mail-pj1-f42.google.com with SMTP id cq9-20020a17090af98900b001b8262fe2d5so4291182pjb.0;
        Thu, 03 Feb 2022 08:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1tNWfA/BVq4Pu1brgQQg4f3LF0dBzZzJ2dAGAeOLqHU=;
        b=5t2iNKY3+lJnRzJ10/4094uGxw8wFiGq73W61LsZisxIsUe7O/o92BTkb6UOjaw96O
         SW91Vy5cBSlzFwxf8RB6n4qwAqkHAbBCpmA0E8zT/kcUAyA38iRFqx4KJ/s9inQEjFdn
         rpn6ngtjcKl9JpZHhxLQhtGJ3u1M6CqrLbKLarfRdh6xpX6h1f4gBQnSXgUqBLn+qJdE
         GPvE3WVYmRgpXmZHEIeTuP3zxQj+IM0QXbgrPj514QgG9PVG6ZDcOtBY78RxC1RqYQ18
         QBSeVEU6YE5cBqDq/MafUBMYdMweXk91dJAflVxVa0qlQD7pEjgd51BnlZSq3AchtpVo
         ZyTw==
X-Gm-Message-State: AOAM533Iz9q0bznZ+HzClLu4Q4o1jCXIBcdx8eyF5PdBMBunwQaWcNIa
        SwEhr8mgrJGtRNPX3dcmRnqK07o8r7WC8A==
X-Google-Smtp-Source: ABdhPJz+d63k2s99MW2oUwmpMARz0qQsAzk0eI0/7mWE/6YWan2johV6nwuipVWV6RGsUrE/Pg5Ipg==
X-Received: by 2002:a17:90a:ba89:: with SMTP id t9mr14653181pjr.21.1643907223251;
        Thu, 03 Feb 2022 08:53:43 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id r7sm2417544pjp.2.2022.02.03.08.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 08:53:42 -0800 (PST)
Message-ID: <54be0878-a7da-cc8a-3efc-1bb0c53caf47@acm.org>
Date:   Thu, 3 Feb 2022 08:53:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] scsi: ufs: disable auto hibern8 while entering suspend
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        'Hoyoung SEO' <hy50.seo@samsung.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        bhoon95.kim@samsung.com, kwmad.kim@samsung.com
Cc:     'kernel test robot' <lkp@intel.com>
References: <CGME20220125062155epcas2p15da28303164091b1bf5a00dcf99fe59b@epcas2p1.samsung.com>
 <20220124180637.160524-1-hy50.seo@samsung.com>
 <40986ecb6c81812a1e1ab24d93e46eda75974c4e.camel@mediatek.com>
 <12a201d81892$c8123d40$5836b7c0$@samsung.com>
 <066101d818ca$5dba71f0$192f55d0$@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <066101d818ca$5dba71f0$192f55d0$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 22:50, Alim Akhtar wrote:
> I am not sure, if this problem is generic and faced by all other UFS vendors.
> If not, how about having a vendor specific call back for your platform only?
> Just a thought.

I agree with the above. Since the code change does not follow from the 
spec, it should be guarded with a check for a new quirk flag.

Thanks,

Bart.
