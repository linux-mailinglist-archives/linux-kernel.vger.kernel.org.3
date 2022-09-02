Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB425AAB66
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiIBJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbiIBJ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:29:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705FCE336
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:28:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p16so2630349ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KHNwV5mx6gUjlOLCRF/PLTfLRK6Nfmd9+PtbuISOuEA=;
        b=M0KeLwxzeSoLJxa8C1OND2HppYCPxKTP+rai1VGnNJLpVe5btrhUxlfQzFc4sRks9N
         Ft0uaS5zd772/WI6qZ+t1Dn7fM7tpxF9Kxk05ZFYWQH+y8akl7KHdRs90/MyhoihNUL1
         iA5PBOvvB71OecyzpG5lIczD0+vDPUcrTWw6uaLegSu57Ky8WplwpIbCFzR+7YTPaFSW
         0xhSV25GhqOo0TMfWHeE4Di+iPEXebOa3/d9C+noOAGDJX9dJtf/59GcdDEGwcmsiisT
         3ffxu+EemzvN4fPjqmTyAQXI/CiOlduE6N3Sv6HiKJq3ilt4TiXyNTWG/sUD+CyOm9vT
         p/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KHNwV5mx6gUjlOLCRF/PLTfLRK6Nfmd9+PtbuISOuEA=;
        b=tKmCOImc4nMRvAi4Ulp11M0rQ9LENHVLa39lFJMB3TyFjK7Vh/gY0mB9Q6wnlzuGO0
         8RwtHGKcRYX63faIyA2z3dQlpk52kMVcWwtIOtQaVagmZH06nUpOI8+6c1MdOZKWc1wB
         aD9oTzmztRIlv2Fqsm/zcSM9ObEvstT/unGC+bNWF8O7PmBgFGJ46zyanvkwOg2HdfQo
         wiatxgWboc8L+u4e5JbB6PHfgQDNS0cpf3jUtlvIt6YW2HZ38Zu6oGzOFbzpbsiUc8fE
         ALyGVaJ/MppP8OY/jSREtk8h0+sep4vNcvjgfXfNJPBSo65gNs3kuNFeIUyHiEvOK2uS
         c4eQ==
X-Gm-Message-State: ACgBeo2p9+Sld6T4mt+ImHgBUQ6nzcinrBI4ImzLZLOGOG/gadDtr1Ge
        /SB+jpkbGMEtSuDeHM7UAiLc/rlmW8gn9vd0MBnwAA==
X-Google-Smtp-Source: AA6agR7FYxmCIOGzTe5dYOt6peYrFJvRHIR7rydBTdT9Hv3Hy7Ey+n+P6uBKXLJQmUb2YiRybJqE/2OV8ewKZip5ycM=
X-Received: by 2002:a17:906:cc57:b0:73d:cdfd:28b4 with SMTP id
 mm23-20020a170906cc5700b0073dcdfd28b4mr25688033ejb.211.1662110915660; Fri, 02
 Sep 2022 02:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220826075839.292615-1-raychi@google.com> <Yw4GH4U5ULV3VFSY@kroah.com>
In-Reply-To: <Yw4GH4U5ULV3VFSY@kroah.com>
From:   Ray Chi <raychi@google.com>
Date:   Fri, 2 Sep 2022 17:28:24 +0800
Message-ID: <CAPBYUsA1oARNuGus5uzxZ7Co+gJrm2V_axCPsyZHhp85cndaAg@mail.gmail.com>
Subject: Re: [PATCH] usb: core: stop USB enumeration if too many retries
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mathias.nyman@linux.intel.com,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Albert Wang <albertccwang@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 8:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 26, 2022 at 03:58:39PM +0800, Ray Chi wrote:
> > If a broken accessory connected to a USB host, usbcore might
> > keep doing enumeration retries and it will take a long time to
> > cause system unstable.
> >
> > This patch provides a quirk to specific USB ports of the hub to
> > stop USB enumeration if needed.
>
> Where does it ever allow the port to handle new devices in the future if
> the device is removed and then a new one is added back?  Or is the port
> just now dead for forever?
>

I modified the patch according to Alan's suggestion, so the port will
be working again
after clearing the quirk with the v2 patch.

> thanks,
>
> greg k-h

Thanks,
Ray
