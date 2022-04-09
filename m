Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84914FA620
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiDIJMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiDIJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:12:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20815C08
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:10:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r13so16127800wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zKNmula4M8WaEFCuyQt+X+sg6b+J30wEG4NDVdlEmfw=;
        b=uTECW+az/g/69POVttkd/BW9dZ9GLVDt4ldrah8nFo6RrLiPvPcCM5QvSgmVqmV3po
         ZdFk3B3zYlgCZ1/8bKoHZJqmKvTDapWg/IRd8dfJLa3taZuCmi8WbPlWxozi/yEwSxD3
         dSoD+7GcPMgxwxGRmvd1GPYIaizbbf0xa7H6H0QSSG0LtwawRpUvaxCJOUH/0o7Ahwnh
         l4BsTc+9jBr9dHvhLgyT4s3QGLQZBHsaha28QkPMY27Nx36RecJHqtGaN51/JYMf2z+r
         dYHdCEqphYoG7apkvMyyK5z88EjEBj+cvBm6gsZtfSsIzvxbvdNNmGRnLwRxqs5SN2D6
         mlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zKNmula4M8WaEFCuyQt+X+sg6b+J30wEG4NDVdlEmfw=;
        b=SPBcvSPBDu+UgOVhRFeMHiUOqJjdKnLXFv2N+C3QL5kWXaOGqX06ipXR+fWbY7O8Nx
         apz0Am8tKaEmjfuOxbEuk7bV0QXfpTLf9qcCdA8Y3KO5okiiv2tH3Nhn2Bp8TkaKzAPH
         GAO0/rqJpowwMpoEOwxdDKrBNDqZkhlEoULb9cR1T78uWRgTb9vaUqYKy6y+ww6SftoM
         fBAX+hPmr4deqnmbiuRP9gKlLknXjn74Km6YPRB0gRZr+HoH7diuYw2wTBzczuCXjwxo
         ejKYWvfqTrwpfl19T6pkhzXst3lENwFu5VunhDOgXPMktSa37WGaEKuR4sE7RVGlc3px
         WxQw==
X-Gm-Message-State: AOAM531UDwqZMCK28Chrz8KSKqlKhQAeDvoS4U4QKjK7jt96w7BkqoNy
        Oz5BjKfaFEzGhl/3+DC8VaPz2w==
X-Google-Smtp-Source: ABdhPJz55r9BpQIYYv9HG1fxE+9koNbEJjQ6f7PEd6EV9RU8GRbV1Ar6RTczJOdQ0ua98aRuvHQV2A==
X-Received: by 2002:adf:f1d1:0:b0:206:1303:ee49 with SMTP id z17-20020adff1d1000000b002061303ee49mr17386609wro.533.1649495424629;
        Sat, 09 Apr 2022 02:10:24 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm17751194wmb.36.2022.04.09.02.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:10:23 -0700 (PDT)
Date:   Sat, 9 Apr 2022 10:10:21 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Enze Li <lienze@kylinos.cn>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] cdrom: make EXPORT_SYMBOL follow exported function
Message-ID: <YlFNfb3IB0KLdnf6@equinox>
References: <20220406090337.1116708-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406090337.1116708-1-lienze@kylinos.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 05:03:37PM +0800, Enze Li wrote:
> Currently, some EXPORT_SYMBOL declarations do not follow the exported
> function, which affects the readability of the code.  To maintain
> consistency, move these EXPORT_SYMBOL declarations to the correct
> position to improve the readability of the code.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  drivers/cdrom/cdrom.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 7bd10d63ddbe..2d9dce967c90 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -648,6 +648,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
>  	mutex_unlock(&cdrom_mutex);
>  	return 0;
>  }
> +EXPORT_SYMBOL(register_cdrom);
>  #undef ENSURE
>  
>  void unregister_cdrom(struct cdrom_device_info *cdi)
> @@ -663,6 +664,7 @@ void unregister_cdrom(struct cdrom_device_info *cdi)
>  
>  	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
>  }
> +EXPORT_SYMBOL(unregister_cdrom);
>  
>  int cdrom_get_media_event(struct cdrom_device_info *cdi,
>  			  struct media_event_desc *med)
> @@ -690,6 +692,7 @@ int cdrom_get_media_event(struct cdrom_device_info *cdi,
>  	memcpy(med, &buffer[sizeof(*eh)], sizeof(*med));
>  	return 0;
>  }
> +EXPORT_SYMBOL(cdrom_get_media_event);
>  
>  static int cdrom_get_random_writable(struct cdrom_device_info *cdi,
>  			      struct rwrt_feature_desc *rfd)
> @@ -1206,6 +1209,7 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
>  	cdi->use_count--;
>  	return ret;
>  }
> +EXPORT_SYMBOL(cdrom_open);
>  
>  /* This code is similar to that in open_for_data. The routine is called
>     whenever an audio play operation is requested.
> @@ -1301,6 +1305,7 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
>  			cdo->tray_move(cdi, 1);
>  	}
>  }
> +EXPORT_SYMBOL(cdrom_release);
>  
>  static int cdrom_read_mech_status(struct cdrom_device_info *cdi, 
>  				  struct cdrom_changer_info *buf)
> @@ -1383,6 +1388,7 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
>  	kfree(info);
>  	return nslots;
>  }
> +EXPORT_SYMBOL(cdrom_number_of_slots);
>  
>  
>  /* If SLOT < 0, unload the current slot.  Otherwise, try to load SLOT. */
> @@ -1582,6 +1588,7 @@ void init_cdrom_command(struct packet_command *cgc, void *buf, int len,
>  	cgc->data_direction = type;
>  	cgc->timeout = CDROM_DEF_TIMEOUT;
>  }
> +EXPORT_SYMBOL(init_cdrom_command);
>  
>  /* DVD handling */
>  
> @@ -2000,6 +2007,7 @@ int cdrom_mode_sense(struct cdrom_device_info *cdi,
>  	cgc->data_direction = CGC_DATA_READ;
>  	return cdo->generic_packet(cdi, cgc);
>  }
> +EXPORT_SYMBOL(cdrom_mode_sense);
>  
>  int cdrom_mode_select(struct cdrom_device_info *cdi,
>  		      struct packet_command *cgc)
> @@ -2015,6 +2023,7 @@ int cdrom_mode_select(struct cdrom_device_info *cdi,
>  	cgc->data_direction = CGC_DATA_WRITE;
>  	return cdo->generic_packet(cdi, cgc);
>  }
> +EXPORT_SYMBOL(cdrom_mode_select);
>  
>  static int cdrom_read_subchannel(struct cdrom_device_info *cdi,
>  				 struct cdrom_subchnl *subchnl, int mcn)
> @@ -2893,6 +2902,7 @@ int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
>  	*last_written = toc.cdte_addr.lba;
>  	return 0;
>  }
> +EXPORT_SYMBOL(cdrom_get_last_written);
>  
>  /* return the next writable block. also for udf file system. */
>  static int cdrom_get_next_writable(struct cdrom_device_info *cdi,
> @@ -3430,18 +3440,7 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
>  
>  	return -ENOSYS;
>  }
> -
> -EXPORT_SYMBOL(cdrom_get_last_written);
> -EXPORT_SYMBOL(register_cdrom);
> -EXPORT_SYMBOL(unregister_cdrom);
> -EXPORT_SYMBOL(cdrom_open);
> -EXPORT_SYMBOL(cdrom_release);
>  EXPORT_SYMBOL(cdrom_ioctl);
> -EXPORT_SYMBOL(cdrom_number_of_slots);
> -EXPORT_SYMBOL(cdrom_mode_select);
> -EXPORT_SYMBOL(cdrom_mode_sense);
> -EXPORT_SYMBOL(init_cdrom_command);
> -EXPORT_SYMBOL(cdrom_get_media_event);
>  
>  #ifdef CONFIG_SYSCTL
>  
> -- 
> 2.25.1
> 

Seems like a sensible change to me, and builds OK. Many thanks for the
patch. As we're now outside the merge window, I will send onto Jens at
the appropriate time.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
