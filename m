Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E1C5B26B4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiIHT3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiIHT3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADD2BCCEB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662665352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qRdy4kAyI0zKoNnvsiAB9duGL/ll3qc1hDDJWJPqTv4=;
        b=cBUMbcBVkighsV8EMvc/z9spQthMQpoykNyu+nTkXwGPhUbbDJ7hDDVRLa/Nq/cSVPcQ8K
        cb4jmNkpuhtr1HG9HuG+rwvh6MD8u61JuVnDoJHgcOTq3eTmta2sBi33uvnY0oHKqT68mc
        KweOxnbsz4w0c12x8HH8sUL0MyxFe5A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-zwbRvOUTNnagOiV8AgoNpg-1; Thu, 08 Sep 2022 15:29:08 -0400
X-MC-Unique: zwbRvOUTNnagOiV8AgoNpg-1
Received: by mail-ed1-f71.google.com with SMTP id f14-20020a0564021e8e00b00448da245f25so12051899edf.18
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 12:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=qRdy4kAyI0zKoNnvsiAB9duGL/ll3qc1hDDJWJPqTv4=;
        b=s7sn2GfKal1lUmcFKsXxItRe149XDA+JimqIuR5RZxTIkD7V41+S6aK1wTeWi6dSmJ
         aVEOAILCSTX5ALE522wUs/cOoQJHE5JJoHHIka+htdHNuz0AOuwxWQOivbwV5QlqDgi1
         8Gd6Oc2YSFw910OP/LtGnaLQmWY3+zfjHmw1rZT6ZSxtbvp/hNIjTwF8MaH4ehxp2L/N
         hczJUmN9clylKc+IqueT7QssilH6Ikx49UCzpkfucWRpyb4KZGriHBfW9+WlhylDRwCn
         jQP3/7ACNgj5Qu+YnJMiBB0H9Dh98SaF2WXMwm+dPOLLwQiTPnQnIVkTQbUwK0yahIZV
         Owng==
X-Gm-Message-State: ACgBeo1YgK+hqImF74Eh4w/LDFF4rOSZ4RWU1va5srd5W7fsaeIhfFE6
        ysBjXUA4PMwUY9U4Ddwv4wajrx4D0fywAzgzGDf+6nu7it9ftQJmJ1KzEgKaYAr/FR2KGg8KX7L
        uQ97AOTiJMb2o3DdA/vYyguQd
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id fj8-20020a0564022b8800b0043a6c586c64mr8651691edb.348.1662665347447;
        Thu, 08 Sep 2022 12:29:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6m0twNMz8+CY/sUrvnpmvu+RhThG9+Ree5xgXpdl3TYREbBnfxLMpSA4PvCCbAZGPyx7QTlA==
X-Received: by 2002:a05:6402:2b88:b0:43a:6c58:6c64 with SMTP id fj8-20020a0564022b8800b0043a6c586c64mr8651677edb.348.1662665347294;
        Thu, 08 Sep 2022 12:29:07 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090630d500b0073d6ab5bcaasm1558295ejb.212.2022.09.08.12.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 12:29:06 -0700 (PDT)
Message-ID: <58c0a316-2bb1-e6f6-27ec-2ffbe8377c3a@redhat.com>
Date:   Thu, 8 Sep 2022 21:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
To:     systemd-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
Subject: DMI modalias based module autoloading broken (6.0.0-rc? - systemd
 251.4) ?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm sending this to both systemd-devel and lkml since I'm not sure
what is causing this.

For some reason the msi-laptop module is not autoloading on a
MSI S270 (yes that is a very old laptop).

Here is some debugging info:

$ cat /sys/class/dmi/id/modalias
dmi:bvnAmericanMegatrendsInc.:bvrA1013AMSV4.30:bd01/09/2006:svnMICRO-STARINT'LCO.,LTD:pnMS-1013:pvr0131:cvnMICRO-STARINT'LCO.,LTD:ct10:cvrN/A:
$ cat /sys/class/dmi/id/uevent
MODALIAS=dmi:bvnAmericanMegatrendsInc.:bvrA1013AMSV4.30:bd01/09/2006:svnMICRO-STARINT'LCO.,LTD:pnMS-1013:pvr0131:cvnMICRO-STARINT'LCO.,LTD:ct10:cvrN/A:
$ modinfo msi-laptop | grep MS-1013
alias:          dmi*:svn*MICRO-STARINT'LCO.,LTD*:pn*MS-1013*:pvr*0131*:cvn*MICRO-STARINT'LCO.,LTD*:

And this does work to load the module:
$ sudo modprobe `cat /sys/class/dmi/id/modalias`

Things already tried:
- checked for relevant selinux denial messages, none found
- checked for modprobe[.d] conf files blacklisting msi-laptop,
  none found which is unsurprising since this is a clean
  Fedora 37 install

I am more then happy to test any patches or do more debugging
to help solve this.

Regards,

Hans

