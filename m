Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873B7492452
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiARLIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:08:19 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16721 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbiARLH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:07:26 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JdQqw0WbdzZf8F;
        Tue, 18 Jan 2022 19:03:40 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 18 Jan 2022 19:07:24 +0800
CC:     <yangyicong@hisilicon.com>,
        Lukasz Maniak <lukasz.maniak@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=c5=81ukasz_Gieryk?= <lukasz.gieryk@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Reset IOV state on FLR to PF
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20220117225542.GA813284@bhelgaas>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <e4483576-cafb-6ba2-a98f-8b7bdcead80d@huawei.com>
Date:   Tue, 18 Jan 2022 19:07:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220117225542.GA813284@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/18 6:55, Bjorn Helgaas wrote:
> [+cc Alex in case he has comments on how FLR should work on
> non-conforming hns3 devices]
> 
> On Sat, Jan 15, 2022 at 05:22:19PM +0800, Yicong Yang wrote:
>> On 2022/1/15 0:37, Bjorn Helgaas wrote:
>>> On Fri, Jan 14, 2022 at 05:42:48PM +0800, Yicong Yang wrote:
>>>> On 2022/1/14 0:45, Lukasz Maniak wrote:
>>>>> On Wed, Jan 12, 2022 at 08:49:03AM -0600, Bjorn Helgaas wrote:
>>>>>> On Wed, Dec 22, 2021 at 08:19:57PM +0100, Lukasz Maniak wrote:
>>>>>>> As per PCI Express specification, FLR to a PF resets the PF state as
>>>>>>> well as the SR-IOV extended capability including VF Enable which means
>>>>>>> that VFs no longer exist.
>>>>>>
>>>>>> Can you add a specific reference to the spec, please?
>>>>>>
>>>>> Following the Single Root I/O Virtualization and Sharing Specification:
>>>>> 2.2.3. FLR That Targets a PF
>>>>> PFs must support FLR.
>>>>> FLR to a PF resets the PF state as well as the SR-IOV extended
>>>>> capability including VF Enable which means that VFs no longer exist.
>>>>>
>>>>> For PCI Express Base Specification Revision 5.0 and later, this is
>>>>> section 9.2.2.3.
>>>
>>> This is also the section in the new PCIe r6.0.  Let's use that.
>>>
>>>>>>> Currently, the IOV state is not updated during FLR, resulting in
>>>>>>> non-compliant PCI driver behavior.
>>>>>>
>>>>>> And include a little detail about what problem is observed?  How would
>>>>>> a user know this problem is occurring?
>>>>>>
>>>>> The problem is that the state of the kernel and HW as to the number of
>>>>> VFs gets out of sync after FLR.
>>>>>
>>>>> This results in further listing, after the FLR is performed by the HW,
>>>>> of VFs that actually no longer exist and should no longer be reported on
>>>>> the PCI bus. lspci return FFs for these VFs.
>>>>
>>>> There're some exceptions. Take HiSilicon's hns3 and sec device as an
>>>> example, the VF won't be destroyed after the FLR reset.
>>>
>>> If FLR on an hns3 PF does *not* clear VF Enable, and the VFs still
>>> exist after FLR, isn't that a violation of sec 9.2.2.3?
>>
>> yes I think it's a violation to the spec.
> 
> Thanks for confirming that.
> 
>>> If hns3 and sec don't conform to the spec, we should have some sort of
>>> quirk that serves to document and work around this.
>>
>> ok I think it'll help. Do you mean something like this based on this patch:
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index 69ee321027b4..0e4976c669b2 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -1025,6 +1025,8 @@ void pci_reset_iov_state(struct pci_dev *dev)
>>  		return;
>>  	if (!iov->num_VFs)
>>  		return;
>> +	if (dev->flr_no_vf_reset)
>> +		return;
>>
>>  	sriov_del_vfs(dev);
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 003950c738d2..c8ffcb0ac612 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1860,6 +1860,17 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
>>
>> +/*
>> + * Some HiSilicon PCIe devices' VF won't be destroyed after a FLR reset.
>> + * Don't reset these devices' IOV state when doing FLR.
>> + */
>> +static void quirk_huawei_pcie_flr(struct pci_dev *pdev)
>> +{
>> +	pdev->flr_no_vf_reset = 1;
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_flr);
>> +/* ...some other devices have this quirk */
> 
> Yes, I think something along this line will help.
> 
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 18a75c8e615c..e62f9fa4d48f 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -454,6 +454,7 @@ struct pci_dev {
>>  	unsigned int	is_probed:1;		/* Device probing in progress */
>>  	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
>>  	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
>> +	unsigned int	flr_no_vf_reset:1;	/* VF won't be destroyed after PF's FLR */
>>
>>>> Currently the transactions with the VF will be restored after the
>>>> FLR. But this patch will break that, the VF is fully disabled and
>>>> the transaction cannot be restored. User needs to reconfigure it,
>>>> which is unnecessary before this patch.
>>>
>>> What does it mean for a "transaction to be restored"?  Maybe you mean
>>> this patch removes the *VFs* via sriov_del_vfs(), and whoever
>>> initiated the FLR would need to re-enable VFs via pci_enable_sriov()
>>> or something similar?
>>
>> Partly. It'll also terminate the VF users.
>> Think that I attach the VF of hns to a VM by vfio and ping the network
>> in the VM, when doing FLR the 'ping' will pause and after FLR it'll
>> resume. Currenlty The driver handle this in the ->reset_{prepare, done}()
>> methods. The user of VM may not realize there is a FLR of the PF as the
>> VF always exists and the 'ping' is never terminated.
>>
>> If we remove the VF when doing FLR, then 1) we'll block in the VF->remove()
>> until no one is using the device, for example the 'ping' is finished.
>> 2) the VF in the VM no longer exists and we have to re-enable VF and hotplug
>> it into the VM and restart the ping. That's a big difference.
>>
>>> If FLR disables VFs, it seems like we should expect to have to
>>> re-enable them if we want them.
>>
>> It involves a remove()/probe() process of the VF driver and the user
>> of the VF will be terminated, just like the situation illustrated
>> above.
> 
> I think users of FLR should be able to rely on it working per spec,
> i.e., that VFs will be destroyed.  If hardware like hns3 doesn't do
> that, the quirk should work around that in software by doing it
> explicitly.
> 
> I don't think the non-standard behavior should be exposed to the
> users.  The user should not have to know about this hns3 issue.
> 
> If FLR on a standard NIC terminates a ping on a VF, FLR on an hns3 NIC
> should also terminate a ping on a VF.
> 

ok thanks for the discussion, agree on that. According to the spec, after
the FLR to the PF the VF does not exist anymore, so the ping will be terminated.
Our hns3 and sec team are still evaluating it before coming to a solution of
whether using a quirk or comform to the spec.

For this patch it looks reasonable to me, but some questions about the code below.

>>>> Can we handle this problem in another way? Maybe test the VF's
>>>> vendor device ID after the FLR reset to see whether it has really
>>>> gone or not?
>>>>
>>>>> sriov_numvfs in sysfs returns old invalid value and does not allow
>>>>> setting a new value before explicitly setting 0 in the first place.
>>>>>
>>>>>>> This patch introduces a simple function, called on the FLR path, that
>>>>>>> removes the virtual function devices from the PCI bus and their
>>>>>>> corresponding sysfs links with a final clear of the num_vfs value in IOV
>>>>>>> state.
>>>>>>>
>>>>>>> Signed-off-by: Lukasz Maniak <lukasz.maniak@linux.intel.com>
>>>>>>> ---
>>>>>>>  drivers/pci/iov.c | 21 +++++++++++++++++++++
>>>>>>>  drivers/pci/pci.c |  2 ++
>>>>>>>  drivers/pci/pci.h |  4 ++++
>>>>>>>  3 files changed, 27 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>>>>>> index 0267977c9f17..69ee321027b4 100644
>>>>>>> --- a/drivers/pci/iov.c
>>>>>>> +++ b/drivers/pci/iov.c
>>>>>>> @@ -1013,6 +1013,27 @@ int pci_iov_bus_range(struct pci_bus *bus)
>>>>>>>  	return max ? max - bus->number : 0;
>>>>>>>  }
>>>>>>>  
>>>>>>> +/**
>>>>>>> + * pci_reset_iov_state - reset the state of the IOV capability
>>>>>>> + * @dev: the PCI device
>>>>>>> + */
>>>>>>> +void pci_reset_iov_state(struct pci_dev *dev)
>>>>>>> +{
>>>>>>> +	struct pci_sriov *iov = dev->sriov;
>>>>>>> +
>>>>>>> +	if (!dev->is_physfn)
>>>>>>> +		return;
>>>>>>> +	if (!iov->num_VFs)
>>>>>>> +		return;
>>>>>>> +
>>>>>>> +	sriov_del_vfs(dev);
>>>>>>> +
>>>>>>> +	if (iov->link != dev->devfn)
>>>>>>> +		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>>>>>>> +
>>>>>>> +	iov->num_VFs = 0;
>>>>>>> +}
>>>>>>> +

Any reason for not using pci_disable_sriov()?

With the spec the related registers in the SRIOV cap will be reset so
it's ok in general. But for some devices not following the spec like hns3,
some fields like VF enable won't be reset and keep enabled after the FLR.
In this case after the FLR the VF devices in the system has gone but
the state of the PF SRIOV cap leaves uncleared. pci_disable_sriov()
will reset the whole SRIOV cap. It'll also call pcibios_sriov_disable()
to correct handle the VF disabling on some platforms, IIUC.

Or is it better to use pdev->driver->sriov_configure(pdev,0)?
PF drivers must implement ->sriov_configure() for enabling/disabling
the VF but we totally skip the PF driver here.

Thanks,
Yicong

>>>>>>>  /**
>>>>>>>   * pci_enable_sriov - enable the SR-IOV capability
>>>>>>>   * @dev: the PCI device
>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>>> index 3d2fb394986a..535f19d37e8d 100644
>>>>>>> --- a/drivers/pci/pci.c
>>>>>>> +++ b/drivers/pci/pci.c
>>>>>>> @@ -4694,6 +4694,8 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>>>>>>>   */
>>>>>>>  int pcie_flr(struct pci_dev *dev)
>>>>>>>  {
>>>>>>> +	pci_reset_iov_state(dev);
>>>>>>> +
>>>>>>>  	if (!pci_wait_for_pending_transaction(dev))
>>>>>>>  		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>>>>>>>  
>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>> index 3d60cabde1a1..7bb144fbec76 100644
>>>>>>> --- a/drivers/pci/pci.h
>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>> @@ -480,6 +480,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
>>>>>>>  resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
>>>>>>>  void pci_restore_iov_state(struct pci_dev *dev);
>>>>>>>  int pci_iov_bus_range(struct pci_bus *bus);
>>>>>>> +void pci_reset_iov_state(struct pci_dev *dev);
>>>>>>>  extern const struct attribute_group sriov_pf_dev_attr_group;
>>>>>>>  extern const struct attribute_group sriov_vf_dev_attr_group;
>>>>>>>  #else
>>>>>>> @@ -501,6 +502,9 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
>>>>>>>  {
>>>>>>>  	return 0;
>>>>>>>  }
>>>>>>> +static inline void pci_reset_iov_state(struct pci_dev *dev)
>>>>>>> +{
>>>>>>> +}
>>>>>>>  
>>>>>>>  #endif /* CONFIG_PCI_IOV */
> .
> 
