Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982F04EB40E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbiC2TYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiC2TYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:24:15 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E496F3B3FD;
        Tue, 29 Mar 2022 12:22:31 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id q11so22197652iod.6;
        Tue, 29 Mar 2022 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vx6btCVYHPVyAnWMa8UET2qF2wjGK6uBYbb8Ohcu3BM=;
        b=kWIjIPL5b8sItwV/jXE6ocblWjihZ88AkbLV8aV0tRZJId0HHri87QJpw3a3+7LN7K
         cbhP6k6jBlXVrJYjyCAvoDNSq057wt7EwRPcYiL9bS0KF/L+HfDbX9Cim4MnPyERXOXX
         Agjf8Mq7Q7P0QJJFA6jjWgd1X9PCGohtRZOEmCj+7sUhzKZda2CaDy/i1NEGIiQsfR5L
         OLLcWDtuseG/wpPSw3eDVE4+aqPqm0oNE1IlEVT5mKk4LPK9P2ReQJVed80wQgqNFGjw
         E6Pk6GqgotMnjyaK/1wzfCxjI6PQVkpJyPJyasj9R3tyq70Fz0GTUY9uLcOALCV8AZ66
         dfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vx6btCVYHPVyAnWMa8UET2qF2wjGK6uBYbb8Ohcu3BM=;
        b=EeLF325OboSoKWBQpCbJkRgd8jzYZnJO8BeU9hrK+BIfdVeFvgRfJI1DhAjuklWXSk
         kaeBm2P2s66KJRVZqN/0LTclzBGjQbijRJpTcoS4qqGsz535qLw9qa4gSv8JOY8VO6B2
         484JHgIPqxLXFnP63SNEMR90K2XAwG/Ncp7/Z6JhLYyghr/YMtSSE8Ge+FVkNuWzoC9h
         vb+rJpn0jYUP4e0MbS/jNn+zRmtrfN8Jia9AWKxek0GCzsvuPQC0Gy2WEiuBVLRXX3QM
         iKoKtUiEFywWsJ0+2RvO18703JyFSJoTWk/mN5whhYBZ5L+W9Ts4gGzP1iOGsprsdwtC
         YnfA==
X-Gm-Message-State: AOAM530oCJtP6JxKtpEHOpBfXi/iUq1meCOLyKyrGLyH6p8mSPsGuCtD
        r7O2POki8Tj9Obnl9d/XOzgwaC5fkq+J+ss5ftBHErsO+Kg=
X-Google-Smtp-Source: ABdhPJxJOiaqiGXi+j2rZ7zXXqxf5U/2OOuNVDmTcfTT760sqa9voylVxS3MRCURCWi4xP16P28PDZfbWWrHUyB3EbA=
X-Received: by 2002:a02:844d:0:b0:317:397b:1765 with SMTP id
 l13-20020a02844d000000b00317397b1765mr17723862jah.67.1648581751380; Tue, 29
 Mar 2022 12:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-2-eugene.shalygin@gmail.com> <16a36e23-bab2-4314-54ea-ff6b1011e6d7@roeck-us.net>
In-Reply-To: <16a36e23-bab2-4314-54ea-ff6b1011e6d7@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Tue, 29 Mar 2022 21:22:20 +0200
Message-ID: <CAB95QATxYy5aj97P=S=L-kGE9dppuEbTYq=K=HGMBuZYVUBR4g@mail.gmail.com>
Subject: Re: [PATCH 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 at 15:44, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> >   struct ec_sensors_data {
> > -     unsigned long board_sensors;
> > +     struct ec_board_info board_info;
>
> Please explain why this needs to be the entire structure and not
> just a pointer to it.

I marked the board_info array as __initconst assuming that this large
array will be unloaded from memory after the init phase, while we keep
only a single element. Is that assumption incorrect?

> > +static int sensor_count(const struct ec_board_info *board)
> > +{
> > +     return hweight_long(board->sensors);
> > +}
>
> This function is called several times. Does it really make sense, or is it
> necessary, to re-calculate the number of sensors over and over again
> instead of keeping it in ec->nr_sensors as before ? What are the benefits ?
> Unless there is a good explanation I see that as unrelated and unnecessary
> change.

This had something to do with data deduplication. However, I need the
count value only for looping over the sensor array, thus I can as well
add an invalid element to the end of the array. I rushed to submit
this driver to replace the wmi one, and it still has an artifact for
the WMI code I'd like to get rid of eventually, which is the read
buffer and the registers array. This will remove all the nr_ variables
and two dynamically allocated arrays. I will understand, of course, if
you ask to submit that refactoring separately.

> > -MODULE_DEVICE_TABLE(dmi, asus_ec_dmi_table);
> >   module_platform_driver_probe(asus_ec_sensors_platform_driver, asus_ec_probe);
> > +MODULE_DEVICE_TABLE(acpi, acpi_ec_ids);
>
> Why is MODULE_DEVICE_TABLE moved ?
Accidentally, probably. Thank you, will be corrected.


Thanks,
Eugene
