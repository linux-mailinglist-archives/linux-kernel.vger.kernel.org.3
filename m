Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D454F100E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377701AbiDDHmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiDDHmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:42:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA9023177;
        Mon,  4 Apr 2022 00:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PUIDKhEMSV8W7g3wJqNXyiqCAktoqkFmb67UEYCm+Wc=; b=B1bwF/oJT1TtqhI6ColMPtiCK3
        VJlTIAPgferYLj2w43f02n0DgtufORkWW68zz+laKdYVZ2zN6wGqH6CfRGPDICQ9xZpPXv4PEfikG
        yNdfnNO14uWK1FsbGQXATOqrH8mLCY8K2VeLtOUjY1F4x0S4G8YK4WnE1Y7Mv4m7F7q1lW66Guyje
        gZFcZbcHZZFu5Ptwi//qMjuaeI9EK8kfP4JF9I57m1c6dJFH8LOFa8uuNJ8U6w0ztIrJGeVfX3nJo
        qzTqrY4z85ufbr74u9Z9mIPCbpQ8YrWvjuxLB6Yzoj6xS5M798Ala1+6vuZAkxnlwK3jLu5j15Dbt
        0fV8lxJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbHJi-00Debc-AC; Mon, 04 Apr 2022 07:40:02 +0000
Date:   Mon, 4 Apr 2022 00:40:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Mike Christie <michael.christie@oracle.com>,
        Wenchao Hao <haowenchao@huawei.com>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        John Garry <john.garry@huawei.com>, Wu Bo <wubo40@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>, zhangjian013@huawei.com
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
Message-ID: <Ykqg0kr0F/yzk2XW@infradead.org>
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
 <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
 <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
 <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
 <1dd69d03-b4f6-ab20-4923-0995b40f045d@suse.de>
 <d2f2c89f-c048-4f04-4d95-27958f0fa46a@huawei.com>
 <78d41ec1-b30c-f6d2-811c-e0e4adbc8f01@oracle.com>
 <84b38f16-2a32-f361-43e5-34bce1012e71@oracle.com>
 <769bcd36-4818-8470-2daa-49ac5c05b33a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <769bcd36-4818-8470-2daa-49ac5c05b33a@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 07:28:00AM +0200, Hannes Reinecke wrote:
> But really, I'd rather get my EH rework in before we're start discussing
> modifying EH behaviour.

Full agreed.  We need to sort that mess out first.
