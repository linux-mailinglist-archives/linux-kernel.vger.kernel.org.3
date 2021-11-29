Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DC9462074
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350454AbhK2TbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhK2T3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:29:00 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E35BC0619E5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:44:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a18so37804719wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B8da+siVIv0pzlfj4HfAjs2ohs1r6S5Zmuk5YtIiRz8=;
        b=nmya3fMcW0VihAIYAjVCrQXx8UpPMQn4Kb9Go+fXFBR0qqr1Bcwl4N7q/NZIkO2zhY
         xk6fk28xgZdlqlZLweQuB4p/OYHcNZA5vGFEkHaEJ2Fk1GIlVmiaQDDfbmfah8J1DnEg
         ZAXvgbAIAxH07TbRTGvxpv/q7DrNKyBbeidLHEJMrOcE0gEytoqo/NNZsHyci6BOrmme
         nv8Ln89giidrpQlp8JlEf07GF7cMHEOfs3LosXgmBbUZCUrqGVqKU2uHm5mAb6s6vkNl
         51NSs70jfYHEFnYHJ1qnBQraUEjL/zlkA38n0IsOnnFRQn6bjg2uBul2+g3ql9LPMtbE
         9U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B8da+siVIv0pzlfj4HfAjs2ohs1r6S5Zmuk5YtIiRz8=;
        b=k7GmdBlyDHeODEn5Qfyjc699msgOTA2d5r5q0m6YV8nVedCKHL0aI++AfLUJEFVa3v
         qlDhRCsmDeLLj8H0KHBz018SLdbfvQGoDCWj6DWIz/WAkxCVuTJPz4Ho+/OIrphtbKcB
         O8AEbJ4dDFHUHuZj/5bN75VlCzk13Kbiwk4pSI02LEYhPwzJbuzBD7CsrSf+fmK+Z1aq
         5+Ku1lduY/lWvUaL6eg4rD2GOgfCdTxRPRwv8/TtV1ehAnUUzyOKi0eOS4aYHpSvaZQ1
         jUDBRU0N4gB7n0ZSzdUDfL6GMZDwQT+vodYMf2pFzQGBgfFTXIQyaYs2e7wvtxnYCPCk
         67ng==
X-Gm-Message-State: AOAM532BqK1tqRQAdERWX5jSspeKgYBGZ+i0iBlm55s9CZc2siXKq7Sf
        M0sp/qOCv35tSZq0cD12LvjTJQ==
X-Google-Smtp-Source: ABdhPJxq8YFXCB4qPdgyGJwD4lEAwTbefpdPX7TGV8LA3IIHoS3SGTWHixAF0+UGrq5fViHR1f49Fg==
X-Received: by 2002:adf:e291:: with SMTP id v17mr34981632wri.479.1638200684688;
        Mon, 29 Nov 2021 07:44:44 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id o9sm14148758wrs.4.2021.11.29.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:44:44 -0800 (PST)
Date:   Mon, 29 Nov 2021 15:44:22 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     joro@8bytes.org, will@kernel.org, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v2 5/5] iommu/virtio: Support identity-mapped domains
Message-ID: <YaT1VvUvpKZhTWvc@myrica>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-6-jean-philippe@linaro.org>
 <58572359-8232-3204-f69a-7f50b887a122@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58572359-8232-3204-f69a-7f50b887a122@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 06:09:56PM +0100, Eric Auger wrote:
> > -			vdomain->viommu = 0;
> > +			vdomain->viommu = NULL;
> nit: that change could have been done in patch 2

Ah yes, I changed that in v2 but fixed up the wrong patch

> >  			return -EOPNOTSUPP;
> >  		}
> > -
> > -		vdomain->bypass = true;
> >  	}
> >  
> >  	return 0;
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!
Jean
