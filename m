Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366E258471C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiG1UmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1UmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:42:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823F6A9EA;
        Thu, 28 Jul 2022 13:42:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z15so3586208edc.7;
        Thu, 28 Jul 2022 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AUfgvoyL15jJ8mjYEoxZFu1v6BK15ah95pPGTCBCygg=;
        b=Q+hxobSzQTkmf7yufOAqyQmWZNdxH1ARaG7jsSFNNZrZcidoMETm+lxqhp/uqrj/fO
         omVJmmcx3JvRcDsqlo/9MlWatY7COY+x0F9XJ9kMU+1ZQuBtTrsX5hyTJakcBzsmikSy
         EfNtZBnQCAQJ+rhWJbcopN+PrfmoMO1EbWyOXC/xqO+tQ9ToOdwo6tSSPcLGxcDfGsFc
         b/Uje8JI+4wzrxl69Fqa5jDagQWriGhoYGI9ubJLAJsu2XHMTm8vSwXrroG0hdT0/NS0
         Bs066QL0sjl7D4JiSyWxodc7DdgXLFi2hhi9O8/8U+eSo4dXN3chKGUbFrzQ3HxzUdj1
         otbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AUfgvoyL15jJ8mjYEoxZFu1v6BK15ah95pPGTCBCygg=;
        b=4G0y2Qelj+jQp6dc7zyztG5cU7USVG3fkqgQrvY4wxKYTV9jRnllscfAXhxG64Jk8P
         ISvwjw4jc4UxeAWhFmshOJ8ljPe3+W9D7afPNlvBdMVftfccWAuQahNPNdIAW3aAbenL
         J6mAJbxlXtAF5LfdGwHQFNS/w2vqXX0tNbl5eTg8J4p74HZJUBUjHO13wAMbS93MyPO4
         PgtQC7KzM5SIJPEmHoos6v16DEu5MR3jKghWzDcB9K3YFaEaj9Njuu5cs/VmVazOWeIW
         /wqroooyMsZOZSPq/melpUWy+ptZne7aVKyXBREDdJn9K1wq0OuaVT1azmm8UE0atZ11
         72pg==
X-Gm-Message-State: AJIora9apkoK47gfVlSjEd1+XshEa6LF6fkb4hMSNFPxv/tCLb0C+FiQ
        E2pmWvd8FLl3EEo7iADjFg0eTUNbGq+a7J3onj/UQOMf
X-Google-Smtp-Source: AGRyM1v2AgrKWdcN5xpns2WA4KJwTLkYuoI/28tFfCD47h/wvbMz+LFtm5PRQdIeWPqC+QJpvl040MbAragnEBvYAH0=
X-Received: by 2002:a05:6402:2714:b0:43c:1c1:717e with SMTP id
 y20-20020a056402271400b0043c01c1717emr700245edd.67.1659040929074; Thu, 28 Jul
 2022 13:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com> <20220728125435.3336618-2-potin.lai.pt@gmail.com>
In-Reply-To: <20220728125435.3336618-2-potin.lai.pt@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jul 2022 22:41:32 +0200
Message-ID: <CAHp75Vf+4Ew2eaccPb3sQY4wAjjsqR7o_uyTUb7eguY=JeDtQA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] iio: humidity: hdc100x: switch to probe_new callback
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 3:32 PM Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> Switch to probe_new callback due to probe is deprecated soon.

Just noticed that commit message is a bit not okay in a few ways:
1) we refer to the callbacks like ->probe_new();
2) we don't know when we deprecate it, the point here is not that, but
unused id parameter in the current code.


-- 
With Best Regards,
Andy Shevchenko
